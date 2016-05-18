class Role < ActiveRecord::Base
  has_many :users, :through =>:role_users
  has_many :roles_access_permissions
  has_many :access_permissions, :through => :roles_access_permissions
end
