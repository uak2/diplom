class Passport < ActiveRecord::Base
  has_many :address_passportes
  has_many :addresses, through: :address_passportes
end
