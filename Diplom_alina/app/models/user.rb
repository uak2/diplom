class User < ActiveRecord::Base

  has_many :role_users
  has_many :roles, :through => :role_users

  attr_accessor :current_role

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

  # Временное решение. По хорошему необходимо в load_user возращать хеш {role=>[array access permissions]}
  # Чтобы не стучаться постоянно в бд
  def check_permission(permission)
    role = Role.includes(:access_permissions).where(id: self.active_role_id).take
    permisssions = []
    role.access_permissions.select(:id).each{|permission| permisssions << permission.id}
    return permisssions.include?(permission.to_i)
  end
end
