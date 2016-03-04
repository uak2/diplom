class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :role_number, :new=>true, :uniq => true
      t.string :role_title, :null => false, :limit => 30

      t.timestamps null: false
    end
  end
end
