class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :person, :index => true, :null => false
      t.integer :a_type, :null=>false, :index => true #1, 2, 3 тип аддресса. Прописка, регистрация, фактическое место жительства
      t.timestamps null: false
    end
  end
end
