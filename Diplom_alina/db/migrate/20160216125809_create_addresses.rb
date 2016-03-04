class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :person, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
