class RolesAccessPermission < ActiveRecord::Base
  belongs_to :role
  belongs_to :access_permission
end
