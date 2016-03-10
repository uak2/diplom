class Person < ActiveRecord::Base
  has_many :addresses
  has_many :passports
  has_many :students
  has_many :files
end
