class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:load_plans_by_speciality_id]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.page(params[:page]).per(20).load
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  def load_plans_by_speciality_id
    render :json => Plan.where(speciality_id: params[:id].to_i).load.map{|plan| [plan.specialization, plan.id]}
  end

  def get_options_terms_by_year_id
    render :json => Term.where(:year_id => params[:year_id].to_i).map{|term| ["#{term.start_year.year}/#{term.end_year.year}", term.id]}
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create

    @plan = Plan.new(plan_params)
    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:speciality_id, :specialization, :count_month, :note)
    end
end
