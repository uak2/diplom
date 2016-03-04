class SubdivisionsController < ApplicationController
  before_action :set_subdivision, only: [:show, :edit, :update, :destroy]

  # GET /subdivisions
  # GET /subdivisions.json
  def index
    @subdivisions = Subdivision.all
  end

  # GET /subdivisions/1
  # GET /subdivisions/1.json
  def show
  end

  # GET /subdivisions/new
  def new
    @subdivision = Subdivision.new
  end

  # GET /subdivisions/1/edit
  def edit
  end

  # POST /subdivisions
  # POST /subdivisions.json
  def create
    @subdivision = Subdivision.new(subdivision_params)

    respond_to do |format|
      if @subdivision.save
        format.html { redirect_to @subdivision, notice: 'Subdivision was successfully created.' }
        format.json { render :show, status: :created, location: @subdivision }
      else
        format.html { render :new }
        format.json { render json: @subdivision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subdivisions/1
  # PATCH/PUT /subdivisions/1.json
  def update
    respond_to do |format|
      if @subdivision.update(subdivision_params)
        format.html { redirect_to @subdivision, notice: 'Subdivision was successfully updated.' }
        format.json { render :show, status: :ok, location: @subdivision }
      else
        format.html { render :edit }
        format.json { render json: @subdivision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subdivisions/1
  # DELETE /subdivisions/1.json
  def destroy
    @subdivision.destroy
    respond_to do |format|
      format.html { redirect_to subdivisions_url, notice: 'Subdivision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subdivision
      @subdivision = Subdivision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subdivision_params
      params.require(:subdivision).permit(:type_num, :type_title)
    end
end
