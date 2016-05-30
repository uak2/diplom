module StudentsHelper
  def date_convert_datepicker(date)
    arr = date.to_s.split("-")
    arr[2] = arr[2].split(" ")[0]
    return "#{arr[1]}/#{arr[2]}/#{arr[0]}"
  end

  def get_options_groups
    options =  Group.all.map{|group| [group.name, group.id]}
    options.unshift(['Ничего не выбрано', 0])
  end

  def get_options_subdivisions
    options = Subdivision.all.load.map{|s| [s.chairisting, s.id]}
    options.unshift(['Ничего не выбрано', 0])
  end

  def get_options_speciality
    options = Speciality.all.map{|speciality| ["#{speciality.number}(#{speciality.name})", speciality.id]}
    options.unshift(['Ничего не выбрано', 0])
  end


  def get_options_years
    options = Year.all.map{|year| ["#{year.start_year.year}/#{year.end_year.year}", year.id]}
    options.unshift(['Ничего не выбрано', 0])
  end


  def get_options_form_study
    options = FormStudy.all.map{|form| [form.name, form.id]}
    options.unshift(['Ничего не выбрано', 0])
  end

  private

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
