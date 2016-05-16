module SpecialitiesHelper
  def getFormStudy
    res = []
    FormStudy.all.each{|fs| res << [fs.name, fs.id]}
    return res
  end
end
