class SearchesController < ApplicationController

  def new

  end

  def create
    redirect_to '/result'
  end

  def result
    attributes = Hash.new
    attributes[:series] = params[:passport_series] unless params[:passport_series].nil? || params[:passport_series].size == 0
    attributes[:number] = params[:passport_number] unless params[:passport_number].nil? || params[:passport_number].size == 0
    attributes[:sex] = params[:sex] if params[:sex].to_s != '0'
    attributes[:first_name] = params[:first_name] unless params[:first_name].nil? || params[:first_name].size == 0
    attributes[:second_name] = params[:second_name] unless params[:second_name].nil? || params[:second_name].size == 0
    attributes[:last_name] = params[:last_name] unless params[:last_name].nil? || params[:last_name].size == 0
    attributes[:birthday] = process_date(params[:birthday]) unless params[:birthday].nil? || params[:birthday].size == 0
    @passport_ids = Passport.where(attributes).select(:id, :person_id)
    
   @students = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).where().page(params[:page]).per(20).load
  end

end