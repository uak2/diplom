class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update]
  attr_reader :delete_objects #объекты будут удалены в случае ошибки создания или обновления объекта
  before_action :set_delete_objects, only: [:create, :update]

  # GET /students
  # GET /students.json
  def index
    @students = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).load
  end

  # GET /students/1
  # GET /students/1.json
  #FIXME переписать алгоритм.
  def show
    @log_change = []
    @tmp = []
    @student_tmp = Student.joins(:person=>[ {photos: :person},{addresses: :person}, {passports: :person}]).where(id:params[:id]).take
    @tmp << @student_tmp.person.photos.last
    @tmp << @student_tmp.person.passports.last
    @tmp << @student_tmp.person.addresses.last
    quick_sort(@tmp, 0, @tmp.size - 1)
    @student_tmp.person.photos.each{|x| @log_change << x}
    @student_tmp.person.passports.each{|x| @log_change << x}
    @student_tmp.person.addresses.each{|x| @log_change << x}
    quick_sort(@log_change, 0, @log_change.size - 1)
    @date_actual = @tmp.last.created_at
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  def del_all
    Passport.delete_all
    Address.delete_all
    Student.delete_all
    Person.delete_all
    Photo.delete_all
    redirect_to '/students'
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
      unless @student.save
        respond_to do |format|
          format.html{redirect_to @student, @student.errors}
        end
      else
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
  def update
    unless params[:photo].nil?
      attr_photo =  {"photo"=>params[:photo]}
      @photo = Photo.new(attr_photo)
      @photo.person = @student.person
      @photo.save
      @delete_objects << @photo
    end

    passport = new_passport(params, @student.person)
    unless (@student.person.passports[0] == passport)
      passport.save
      @delete_objects << passport
    end

    unless params[:propiska] == @p_address.address
      @delete_objects << save_address(1, params[:propiska], @student.person)
    end
    unless params[:registration] == @r_address.address
      @delete_objects << save_address(2, params[:registration], @student.person)
    end
    unless params[:fackt] == @f_address.address
      @delete_objects << save_address(3, params[:fackt], @student.person)
    end

    # Студенчиский будет неизменным

    respond_to do |format|
      format.html{redirect_to @student, notice: 'Студент отредактирован успешно'}
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).where(id:params[:id]).take
      @p_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>1).take
      @r_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>2).take
      @f_address = Address.where(:person_id => @student.person.id).order("addresses.id DESC").limit(1).where(:a_type=>3).take
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
