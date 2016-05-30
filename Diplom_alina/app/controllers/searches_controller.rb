class SearchesController < ApplicationController

  def new

  end

  def create
    redirect_to '/result'
  end

  def result
    @person_ids = []

    # select  person_ids by passport
    attributes = Hash.new
    attributes[:series] = params[:passport_series] unless params[:passport_series].nil? || params[:passport_series].size == 0
    attributes[:number] = params[:passport_number] unless params[:passport_number].nil? || params[:passport_number].size == 0
    attributes[:sex] = params[:sex] if params[:sex].to_s != '0'
    attributes[:first_name] = params[:first_name] unless params[:first_name].nil? || params[:first_name].size == 0
    attributes[:second_name] = params[:second_name] unless params[:second_name].nil? || params[:second_name].size == 0
    attributes[:last_name] = params[:last_name] unless params[:last_name].nil? || params[:last_name].size == 0
    attributes[:birthday] = process_date(params[:birthday]) unless params[:birthday].nil? || params[:birthday].size == 0
    res = Passport.where(attributes).select(:person_id).map{|ps| ps.person_id} if attributes.size > 0
    @person_ids.concat(res) unless res.nil? # if res is not nil
    attributes.clear

    # select person_ids from student by ducket_number
    attributes[:ducket_number] = params[:ducket_number] unless params[:ducket_number] == ''
    @person_ids.concat(Student.select(:person_id).where(attributes).map{|st| st.person_id})  if attributes.size > 0
    attributes.clear

    #  select person_ids from year and term
    if params[:year].to_i > 0
      if params[:term].to_i > 0
        attributes[:id] = params[:term]
        # @person_ids = (@person_ids | Term.where(:id => params[:term].to_i).map{|term| term.})
      end
    end

   @students = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).where(id: @person_ids).page(params[:page]).per(20).load
  end

end