class Plan < ActiveRecord::Base
  has_many :student_periods
  belongs_to :speciality
end
