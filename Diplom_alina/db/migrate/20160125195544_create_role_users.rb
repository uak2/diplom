class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users do |t|
      t.belongs_to :role, :new => true, :null => false
      t.belongs_to :user, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
