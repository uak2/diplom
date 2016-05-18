class AccessPermission < ActiveRecord::Base
  has_many :roles_access_permissions, :dependent => :destroy
  has_many :roles, :through => :roles_access_permissions
end
