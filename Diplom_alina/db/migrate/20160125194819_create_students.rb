class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.datetime :ducket_date
      t.integer :ducket_number, :uniq => true

      t.timestamps null: false
    end
  end
end
