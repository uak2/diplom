class CreateFibs < ActiveRecord::Migration
  def change
    create_table :fibs do |t|
      t.belongs_to :people, :null=>false, :new => true
      t.string :photo
      t.timestamps null: false
    end
  end
end
