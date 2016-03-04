class Person < ActiveRecord::Base
  has_many :addresses
  has_many :students
  has_many :fibs
end
