class Passport < ActiveRecord::Base
  belongs_to :person


  public

  def - (passport)
    result = []
    result << [self.person_id, passport.person_id] if  self.person_id != passport.person_id
    result << [self.series, passport.series] if  self.series != passport.series
    result << [self.number, passport.number] if self.number!= passport.number
    result << [self.code_subdivision, passport.code_subdivision] if self.code_subdivision != passport.code_subdivision
    result << [self.date_extradition, passport.date_extradition] if self.date_extradition.to_date != passport.date_extradition.to_date
    result << [self.passport_issued, passport.passport_issued] if self.passport_issued != passport.passport_issued
    result << [self.sex, passport.sex] if self.sex != passport.sex
    result << [self.birthday, passport.birthday] if self.birthday.to_date != passport.birthday.to_date
    result << [self.birth_city, passport.birth_city] if self.birth_city != passport.birth_city
    result << [self.first_name, passport.first_name] if self.first_name != passport.first_name
    result << [self.second_name, passport.second_name] if self.second_name != passport.second_name
    result << [self.last_name, passport.last_name] if self.last_name != passport.last_name
    return result
  end

  # сравнение по значениям без сравнения id
  def == (passport)
    return false if  self.person_id != passport.person_id
    return false if  self.series != passport.series
    return false if self.number!= passport.number
    return false if self.code_subdivision != passport.code_subdivision
    return false if self.date_extradition.to_date != passport.date_extradition.to_date
    return false if self.passport_issued != passport.passport_issued
    return false if self.sex != passport.sex
    return false if self.birthday.to_date != passport.birthday.to_date
    return false if self.birth_city != passport.birth_city
    return false if self.first_name != passport.first_name
    return false if self.second_name != passport.second_name
    return false if self.last_name != passport.last_name
    return true
  end

end
