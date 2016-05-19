class User < ActiveRecord::Base

  has_many :role_users
  has_many :roles, :through => :role_users

  has_secure_password

  validates :login, uniqueness: true
  validates :password, length: {minimum: 6, allow_blank: true}

  def getActiveRole
    Role.where(id:self.active_role_id).take
  end

  def getDeactiveRoles
    deactive_roles = []
    self.roles.each do |role|
      deactive_roles << role if role.id != self.active_role_id
    end
    deactive_roles
  end

end
