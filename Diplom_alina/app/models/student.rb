class Student < ActiveRecord::Base
  has_many :student_periods
  has_many :groups, :through => :student_periods
  has_many :plans, :through => :student_periods
  has_many :terms, :through => :student_periods
  belongs_to :person
end
