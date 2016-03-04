class Group < ActiveRecord::Base
  has_many :student_periods
  has_many :subdivision_groups
  has_many :subdivisions, :through => :subdivision_groups
end
