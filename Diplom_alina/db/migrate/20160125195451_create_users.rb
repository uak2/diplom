class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, :unique => true, :new => true, :null => false, :limit => 30
      t.string :password_digest, :null => false, :limit => 300
      t.integer :active_role_id

      t.datetime :last_login

      t.timestamps null: false
    end
  end
end
