class Term < ActiveRecord::Base
  belongs_to :year
  has_many :student_periods
end
