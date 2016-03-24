class SearchesController < ApplicationController

  attr_reader :results

  def new

  end

  def create
    redirect_to '/result'
  end

  def result
    @results = []
    @results << {'FIO'=>"Иванов Иван Иванович", 'photo'=>'1.jpg', 'birthday' => '23.11.1992', 'group'=>'230100', 'start'=>'2013'}
    @results << {'FIO'=>"Иванов Петр Иванович", 'photo'=>'2.jpg','birthday' => '01.12.1994', 'group'=>'230100', 'start'=>'2012'}
    @results << {'FIO'=>"Иванов Федор Михайлович", 'photo'=>'3.jpg', 'birthday' => '03.1.1992', 'group'=>'230100', 'start'=>'2012' }
    @results << {'FIO'=>"Иванов Федор Александрович", 'photo'=>'4.jpg', 'birthday' => '17.07.1995', 'group'=>'230100', 'start'=>'2014'}
    @results << {'FIO'=>"Иванов Иван Иванович", 'photo'=>'5.jpg', 'birthday' => '17.27.1995', 'group'=>'230100', 'start'=>'2013'}
    @results << {'FIO'=>"Иванов Иван Иванович", 'photo'=>'6.jpg', 'birthday' => '07.07.1995', 'group'=>'230100', 'start'=>'2012'}
  end



end