class Term < ActiveRecord::Base
  belongs_to :year
  has_many :student_periods


  def change_display(term)
  	result = ['Учебный отрезок']
    result << ['изменено начало учебного периода', self.start_term, term.start_term] if self.start_term != term.start_term
  	result << ['Изменен конец учебного периода', self.end_term, term.end_term] if self.end_term != term.end_term
  	result << ['Изменен учебный год', self.year, term.year] if self.year.id != term.year.id 
  	result << term.created_at
  	return result
  end

end
