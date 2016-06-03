class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update]
  attr_reader :delete_objects #объекты будут удалены в случае ошибки создания или обновления объекта
  before_action :set_delete_objects, only: [:create, :update]
  skip_after_action :load_current_user, only: [:state_by_date]
  skip_before_filter :verify_authenticity_token, only: [:state_by_date]

  # GET /students
  # GET /students.json
  def index
    @students = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).load
  end

  # GET /students/1
  # GET /students/1.json
  #FIXME переписать алгоритм.
  def show
    return redirect_to '/' unless @student
    @log_change = []
    change_list = ChangeList.where(person_id: @student.person.id).order('id DESC').load
    change_list.each do |row|
      if row.m_type == Passport.model_name.name
        @log_change << Passport.find(row.old_id).change_display(Passport.find(row.new_id))
      elsif row.m_type == Address.model_name.name
        @log_change << Address.find(row.old_id).change_display(Address.find(row.new_id))
      elsif row.m_type == Photo.model_name.name
        @log_change << Photo.find(row.old_id).change_display(Photo.find(row.new_id))
      end
    end
    @date_actual = change_list.size != 0 ? change_list.first.created_at : @student.created_at
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  def state_by_date
    result = {}
    @student = Student.joins(:person).where(id:params[:student_id]).take
    result['student'] = @student
    result['date_actual'] = params[:date].to_date

    if @student != nil
      @photo = Photo.where(:person_id => @student.person_id).where('created_at <= ?', params[:date]).last
      result['photo'] = {'url' => @photo.photo.url, 'url_medium' => @photo.photo.url(:medium)}
      @passport = Passport.where("passports.person_id = ? AND passports.created_at <= ?", @student.person.id, params[:date]).last
      result['passport'] = @passport
      @p_address = Address.where(:person_id => @student.person.id).where(:a_type=>1).where('created_at <= ?', params[:date]).last
      result['p_address'] = @p_address.address
      @r_address = Address.where(:person_id => @student.person.id).where(:a_type=>2).where('created_at <= ?', params[:date]).last
      result['r_address'] = @r_address.address
      @f_address = Address.where(:person_id => @student.person.id).where(:a_type=>3).where('created_at <= ?', params[:date]).last
      result['f_address'] = @f_address.address
    end
    return render :json => result
  end


  # POST /students
  # POST /students.json
  def create
    begin
      @person = save_person(params)
      unless params[:propiska].nil?
        save_address(1, params[:propiska], @person)
      end
      unless params[:registration].nil?
        save_address(2, params[:registration], @person)
      end
      unless params[:fackt].nil?
        save_address(3, params[:fackt], @person)
      end
      unless params[:photo].nil?
        attr_photo =  {"photo"=>params[:photo]}
        @photo = Photo.new(attr_photo)
        @photo.person = @person
        @photo.save
        @delete_objects << @photo
      end
      save_passport(params, @person)
      @student = Student.new(student_params)
      @student.ducket_date = process_date(student_params[:ducket_date])
      @student.person = @person

      # saving with terms
      # year = Year.where()
      st_per = StudentPeriod.new
      st_per.term_id = params[:study_term].to_i
      st_per.group_id = params[:group].to_i
      st_per.plan_id = params[:plan].to_i


      unless @student.save
        respond_to do |format|
          format.html{redirect_to @student, @student.errors}
        end
      else
        st_per.student = @student
        st_per.save
        respond_to do |format|
          format.html{redirect_to @student, notice: 'Студент успешно создан'}
        end
      end

    rescue ActiveRecord::StatementInvalid
      err = delete_objects()
      redirect_to '/students/new?err='+err.zip.to_s
    end

  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  # FIXME необходимо удалять @delete_objects  в случае провала сохранения изменений.
  # А так же удалять список изменений
  def update
    old_id = @student.person.photos.last.id
    unless params[:photo].nil?
      attr_photo =  {'photo'=>params[:photo]}
      @photo = Photo.new(attr_photo)
      @photo.person = @student.person
      @photo.save
      @delete_objects << @photo
      save_change(@photo.model_name.name, @student.person.id, old_id, @photo.id)
    end

    passport = new_passport(params, @student.person)
    old_id = @student.person.passports.last.id
    unless (@student.person.passports.last == passport)
      passport.save
      @delete_objects << passport
      save_change(passport.model_name.name, @student.person.id, old_id, passport.id)
    end

    unless params[:propiska] == @p_address.address
      old_id = @p_address.id
      @delete_objects << save_address_with_change(1, params[:propiska], @student.person, old_id)
    end
    unless params[:registration] == @r_address.address
      old_id = @r_address.id
      @delete_objects << save_address_with_change(2, params[:registration], @student.person, old_id)
    end
    unless params[:fackt] == @f_address.address
      old_id = @f_address.id
      @delete_objects << save_address_with_change(3, params[:fackt], @student.person, old_id)
    end

    # Студенчиский будет неизменным


    # saving with student_periods
    st_per = StudentPeriod.new
    st_per.term_id = params[:study_term].to_i
    st_per.group_id = params[:group].to_i
    st_per.plan_id = params[:plan].to_i
    st_per.student = @student
    st_per.save
    respond_to do |format|
      format.html{redirect_to @student, notice: 'Студент отредактирован успешно'}
    end

  end

  private

    def save_change(name, person_id, old_id, new_id)
       c = nil
      begin
        c = ChangeList.create({m_type: name, person_id: person_id, old_id: old_id, new_id: new_id})
      rescue Exception
        print "При сохранении изменений произошли ошибки #{name} #{person_id} #{old_id} #{new_id}"
      end
      return c
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.includes(:person=>[ {photos: :person}, {passports: :person}]).where(id:params[:id]).take
      if @student != nil
        @p_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>1).take
        @r_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>2).take
        @f_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>3).take
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:ducket_date, :ducket_number)
    end

    def set_delete_objects
      @delete_objects = []
    end

    def delete_objects
      errors = []
      @delete_objects.each{|obj| errors << obj.errors.message.to_s; obj.delete}
      return errors
    end

    def address_params(type, address)
      {:a_type=>type, :address=>address}
    end


    def save_address_with_change(a_type, address, person, old_id)
      address = save_address(a_type, address, person)
      c_address = a_type == 1 ? @p_address : (a_type == 2 ? @r_address: @f_address)
      save_change(address.model_name.name, @student.person.id, old_id, address.id)
    end

    def save_address(a_type, address, person)
      address = Address.new(address_params(a_type, address))
      address.person = person

      unless address.save
        respond_to do |format|
          format.html{render :new, errors: "Не удалось сохранить один из адрессов.Обратитесь к администратору"}
        end
      end
      @delete_objects << address
      return address
    end


    def save_person(params)
      person = Person.new
      unless person.save
        respond_to do |format|
          format.html{render :new, person.errors}
        end
      end
      @delete_objects << person
      return person
    end

    def passport_params
      params.permit(:series, :number, :code_subdivision, :passport_issued, :sex,:birth_city, :first_name, :second_name, :last_name)
    end

    def new_passport(params, person)
      passport = Passport.new(passport_params)
      passport.date_extradition = process_date(params[:date_extradition])
      passport.birthday = process_date(params[:birthday])
      passport.person = person
      return passport
    end

    def save_passport(params, person)
      passport = new_passport(params, person)
      unless passport.save
        respond_to do |format|
          format.html{render :new, passport.errors}
        end
      end
      @delete_objects << passport
      return passport
    end

    # array objects sort by field created_at
    def quick_sort(s_arr, first, last)
      i = first
      j = last
      tmp = 0
      x = s_arr[first + (last - first) / 2]
      while (i <= j)

      while (s_arr[i].created_at > x.created_at)
          i+=1
        end
        while (s_arr[j].created_at < x.created_at)
          j-=1
        end

        if(i <= j)
            if (s_arr[i].created_at < s_arr[j].created_at)
              tmp = s_arr[i]
              s_arr[i] =  s_arr[j]
              s_arr[j] = tmp
            end
          i+=1
          j-=1
        end
      end
      quick_sort(s_arr, i, last)  if (i < last)
      quick_sort(s_arr, first, j) if (first < j)

    end

end
