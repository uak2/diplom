class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    # @student = Student.new(student_params)
    # @student.ducket_date = process_date(student_params[:ducket_date])
    # redirect_to @student
    # unless params[:propiska].nil?
    #   @p_address = Address.new(address_params(1, params[:propiska]))
    # end
    # unless params[:registration].nil?
    #   @r_address = Address.new(address_params(2, params[:registration]))
    # end
    # unless params[:fackt].nil?
    #   @p_address = Address.new(address_params(3, params[:fackt]))
    # end
    unless params[:photo].nil?
      # raise params[:photo].to_yaml
      raise params[:photo].tempfile
      @photo = Photo.new(params[:photo][:temp_file])
      raise @photo.to_s
      # @photo.photo = params[:photo]
      @photo.save
    end
    # raise @student.
    #
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
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

    def address_params(type, address)
      # params.permit(:a_type, :address)
      {:a_type=>type, :address=>address}
    end

end
