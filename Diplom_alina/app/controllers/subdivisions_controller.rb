class SubdivisionsController < ApplicationController
  before_action :set_subdivision, only: [:show, :edit, :update, :destroy]
  skip_after_action :load_current_user, only: [:create_type, :create, :subdivisions_for_select]
  skip_before_filter :verify_authenticity_token, only: [:create_type, :create, :subdivisions_for_select]

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

  def subdivisions_for_select
    render :json => Subdivision.all
  end

  def create_type
    t = TypeSubdivision.new
    t.title=params['type_title']
    if t.save
      return render :json => {'status'=> 'ok', 'type' => t}
    end
     render :json => {'status'=> 'fail', 'type' => nil}
  end


  # POST /subdivisions
  # POST /subdivisions.json
  def create
    @subdivision = Subdivision.new
    @subdivision.type_subdivision_id=params['type_id'].to_i
    @subdivision.institution = params['institution']
    @subdivision.chairisting = params['chairisting']
    if @subdivision.save
      return render :json => {'status' => 'ok', 'subdivision'=>@subdivision}
    end
    render :json => {'status' => 'fail', 'subdivision' => nil}
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
      params.require(:subdivision).permit(:chairisting, :institution)
    end
end
