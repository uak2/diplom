class SearchesController < ApplicationController

  def new

  end

  def create
    redirect_to '/result'
  end

  def result
   @students = Student.joins(:person=>[ {photos: :person}, {passports: :person}]).page(params[:page]).per(20).load
  end

end