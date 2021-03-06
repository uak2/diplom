class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  skip_after_action :load_current_user, only: [:create, :load_groups_by_subdivision_id]
  skip_before_filter :verify_authenticity_token, only: [:create, :load_groups_by_subdivision_id]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.includes(:subdivisions).page(params['page']).per(10).load
    @date_actual = Date.new
  end

  def load_groups_by_subdivision_id
    return render :json => [['Не выбрано', 0]] unless params.nil? || params[:subdivision_id].to_i != 0
    # render :json => Group.where(id: params[:subdivision_id]).load.map{|g| [g.name, g.id]}
    render :json => Subdivision.joins(:groups).where(id: params[:subdivision_id]).first.groups.map{|g| [g.name, g.id]}

  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @subdivisions = Subdivision.where(id: params['subdivisions']).load
    @group.subdivisions = @subdivisions
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group.name=params['group']['name']
    @subdivision = Subdivision.where(id: params['subdivision'].to_i).load
    @group.subdivisions = @subdivision
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.includes(:subdivisions).find(params[:id].to_i);
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
