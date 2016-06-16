class StudentPeriod < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  belongs_to :plan
  belongs_to :group


  def change_display(student_period)
  	result = ['данные о студенте']
   #  result << ['Изменена серия паспарта', self.series, passport.series] if  self.series != passport.series
    result << student_period.created_at
    return result
  end

end
