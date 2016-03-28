class SearchesController < ApplicationController

  attr_reader :results

  def new

  end

  def create
    redirect_to '/result'
  end

  def result
    @results = []
    @results << {'FIO'=>"Анна Иванова Владимировна", 'photo'=>'/system/photos/photos/000/000/013/medium/Rj3PFzoo4O4.jpg?1459147897', 'birthday' => '23.11.1992', 'group'=>'230100', 'start'=>'2012'}
  end



end