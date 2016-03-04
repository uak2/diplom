class AddressPassport < ActiveRecord::Base
  belongs_to :passport
  belongs_to :address
end