class Group < ActiveRecord::Base
  has_many :student_periods
  has_many :subdivision_groups
  has_many :subdivisions, :through => :subdivision_groups

  def change_display(group)
  	result = ['Группа']
  	result << ['измененно имя группы', self.name, group.name] if self.name != group.name
  	result << group.created_at
  	return result
  end

end
