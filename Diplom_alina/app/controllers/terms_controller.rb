class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  skip_after_action :load_current_user, only: [:create_year]
  skip_before_filter :verify_authenticity_token, only: [:create_year]
  # GET /terms
  # GET /terms.json
  def index
    @terms = Term.includes(:year).load
  end

  # GET /terms/1
  # GET /terms/1.json
  def show
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  # POST /terms.json
  def create
    @term = Term.new
    @term.start_term = process_date(params['term']['start_term'])
    @term.end_term = process_date(params['term']['end_term'])
    @term.year_id = params['year'].to_i
    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Term was successfully created.' }
        format.json { render :show, status: :created, location: @term }
      else
        format.html { render :new }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_year
    year = Year.new
    year.start_year = process_date(params['start_year'])
    year.end_year= process_date(params['end_year'])
     if year.save
       return render json: {'status' => 'ok', 'data' => (year.start_year.year.to_s + "/" + year.end_year.year.to_s), 'id' => year.id}
     end
    render json: {'status' => 'fail'}
  end

  # PATCH/PUT /terms/1
  # PATCH/PUT /terms/1.json
  def update
    @term.start_term = process_date(params['term']['start_term'])
    @term.end_term = process_date(params['term']['end_term'])
    @term.year_id = params['year'].to_i
    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Обновления успешны' }
        format.json { render :show, status: :ok, location: @term }
      else
        format.html { render :edit }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @term.destroy
    respond_to do |format|
      format.html { redirect_to terms_url, notice: 'Term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:start_term, :end_term)
    end
end
