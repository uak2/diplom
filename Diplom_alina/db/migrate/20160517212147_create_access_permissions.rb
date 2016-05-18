class CreateAccessPermissions < ActiveRecord::Migration
  def change
    create_table :access_permissions do |t|
      t.string :note

      t.timestamps null: false
    end
  end
end
