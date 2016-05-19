module ApplicationHelper
  #FIXME  stupid, rewrite
  def getStudyYear
    res = []
    Year.all.each{|year| res << [year.start_year.year.to_s + "/" +  year.end_year.year.to_s, year.id]}
    return res
  end

  def check_permission(permission)
    @current_permissions.include?(permission.to_i)
  end

end
