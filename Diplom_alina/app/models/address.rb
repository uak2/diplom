class Address < ActiveRecord::Base
  # has_many :address_passportes
  # has_many :passportes, throgh: :address_passportes
  belongs_to :person
  # belongs_to :passport

  ADDRESS_TYPE = {1=>'Адресс прописки', 2 => 'Адресс регистрации', 3 => 'Адресс фактического проживания'}

  public

  def change_display(address)
    result = [ADDRESS_TYPE[self.a_type]]
    result << ['Изменен',self.address, address.address] if  self.address != address.address
    result << address.created_at
    return result
  end
end