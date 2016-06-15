class StudentPeriod < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  belongs_to :plan
  belongs_to :group


  def change_display(passport)
  	result = []

  	# term year

  	



    result = ['Паспорт']
    result << ['Изменена серия паспарта', self.series, passport.series] if  self.series != passport.series
    result << ['Изменен номер пасспорта', self.number, passport.number] if self.number!= passport.number
    result << ['Изменен код подразделения', self.code_subdivision, passport.code_subdivision] if self.code_subdivision != passport.code_subdivision
    result << ['Изменена дата выдачи', self.date_extradition.to_date, passport.date_extradition.to_date] if self.date_extradition.to_date != passport.date_extradition.to_date
    result << ['Изменено кем выдан пасспорт', self.passport_issued, passport.passport_issued] if self.passport_issued != passport.passport_issued
    result << ['Изменен пол', SEX[self.sex], SEX[passport.sex]] if self.sex != passport.sex
    result << ['Изменена дата рождения', self.birthday.to_date, passport.birthday.to_date] if self.birthday.to_date != passport.birthday.to_date
    result << ['Изменен город рождения', self.birth_city, passport.birth_city] if self.birth_city != passport.birth_city
    result << ['Изменено имя', self.first_name, passport.first_name] if self.first_name != passport.first_name
    result << ['Изменена фамилия', self.second_name, passport.second_name] if self.second_name != passport.second_name
    result << ['Изменено отчество', self.last_name, passport.last_name] if self.last_name != passport.last_name
    result << passport.created_at
    return result
  end

end
