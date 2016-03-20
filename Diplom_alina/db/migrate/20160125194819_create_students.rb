class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.datetime :ducket_date, :null => false
      t.integer :ducket_number, :uniq => true
      t.belongs_to :person, :index => true, :null => false
      t.timestamps null: false
    end
  end
end
