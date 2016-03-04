class FibsController < ApplicationController
  before_action :set_fib, only: [:show, :edit, :update, :destroy]

  # GET /fibs
  # GET /fibs.json
  def index
    @fibs = Fib.all
  end

  # GET /fibs/1
  # GET /fibs/1.json
  def show
  end

  # GET /fibs/new
  def new
    @fib = Fib.new
  end

  # GET /fibs/1/edit
  def edit
  end

  # POST /fibs
  # POST /fibs.json
  def create
    @fib = Fib.new(fib_params)

    respond_to do |format|
      if @fib.save
        format.html { redirect_to @fib, notice: 'Fib was successfully created.' }
        format.json { render :show, status: :created, location: @fib }
      else
        format.html { render :new }
        format.json { render json: @fib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fibs/1
  # PATCH/PUT /fibs/1.json
  def update
    respond_to do |format|
      if @fib.update(fib_params)
        format.html { redirect_to @fib, notice: 'Fib was successfully updated.' }
        format.json { render :show, status: :ok, location: @fib }
      else
        format.html { render :edit }
        format.json { render json: @fib.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fibs/1
  # DELETE /fibs/1.json
  def destroy
    @fib.destroy
    respond_to do |format|
      format.html { redirect_to fibs_url, notice: 'Fib was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fib
      @fib = Fib.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fib_params
      params.require(:fib).permit(:belong_to)
    end
end
