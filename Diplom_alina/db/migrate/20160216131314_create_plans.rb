class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.belongs_to :speciality, :new => true, :null => false  #связь со специальностью
      t.string :specialization, :null => false, :limit => 255 #специализация
      t.integer :count_month, :null => false, :default => 0
      t.text :note, :limit => 2048     #описание особенностей плана.

      t.timestamps null: false
    end
  end
end
