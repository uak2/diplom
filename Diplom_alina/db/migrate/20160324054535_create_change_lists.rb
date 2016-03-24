class CreateChangeLists < ActiveRecord::Migration
  def change
    create_table :change_lists do |t|
      t.string :m_type, :index => true, :null => false
      t.belongs_to  :person, :index => true, :null => false
      t.integer :old_id, :index => true, :null => false
      t.integer :new_id, :index => true, :null => false
      t.timestamps null: false
    end
  end
end
