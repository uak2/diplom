module PlansHelper
  def getSpecialities
    res = []
    Speciality.all.each{|spec| res << [spec.name, spec.id]}
    return res
  end
end
