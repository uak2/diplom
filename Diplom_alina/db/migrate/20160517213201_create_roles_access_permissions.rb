class CreateRolesAccessPermissions < ActiveRecord::Migration
  def change
    create_table :roles_access_permissions do |t|
      t.belongs_to :role, :index=>true, :null=>false
      t.belongs_to :access_permission, :index=>true, :null=>false
      t.timestamps null: false
    end
  end
end
