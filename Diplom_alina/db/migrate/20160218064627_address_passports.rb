class AddressPassports < ActiveRecord::Migration
  def change
    create_table :address_passports do |t|
      t.belongs_to :address, :new => true, :null => false
      t.belongs_to :passport, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
