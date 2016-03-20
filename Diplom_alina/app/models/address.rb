class Address < ActiveRecord::Base
  # has_many :address_passportes
  # has_many :passportes, throgh: :address_passportes
  belongs_to :person
  # belongs_to :passport
end