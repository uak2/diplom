class User < ActiveRecord::Base

  has_many :role_users
  has_many :roles, :through => :role_users

  attr_accessor :current_role

  has_secure_password

  validates :login, uniqueness: true
  validates :password, length: {minimum: 6, allow_blank: true}

end
