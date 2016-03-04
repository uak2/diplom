class StudentPeriod < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  belongs_to :plan
  belongs_to :group
end
