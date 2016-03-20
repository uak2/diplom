class StudentsController < ApplicationController
  before_action :set_student, only: [ :edit, :update, :destroy]
  attr_reader :delete_objects #объекты будут удалены в случае ошибки создания или обновления объекта
  before_action :set_delete_objects, only: [:create]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.joins(:person=>[ {photos: :person}, {addresses: :person}, {passports: :person}]).where(id:params[:id]).take
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
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
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

    def save_passport(params, person)
      passport = Passport.new(passport_params)
      passport.date_extradition = process_date(params[:date_extradition])
      passport.birthday = process_date(params[:birthday])
      passport.person = person
      unless passport.save
        respond_to do |format|
          format.html{render :new, passport.errors}
        end
      end
      @delete_objects << passport
      return passport
    end

end
