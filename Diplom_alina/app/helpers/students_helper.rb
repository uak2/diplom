module StudentsHelper
  def date_convert_datepicker(date)
    arr = date.to_s.split("-")
    arr[2] = arr[2].split(" ")[0]
    return "#{arr[1]}/#{arr[2]}/#{arr[0]}"
  end
end
