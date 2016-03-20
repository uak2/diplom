class Person < ActiveRecord::Base
  has_many :addresses
  has_many :passports
  has_one :student
  has_many :photos
end
