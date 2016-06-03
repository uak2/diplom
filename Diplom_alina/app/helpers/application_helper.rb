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


  def get_name_by_month(month)
    month_num = month.to_i
    return 'Ошибка даты' if !month_num
    if   month_num <=2 || month_num == 12
      return 'Зима'
    elsif month_num > 2 && month_num < 7
      return 'Весна'
    elsif month_num > 6 && month_num < 9
      return 'Лето'
    elsif month_num > 8
      return 'Осень'
    end
  end

end
