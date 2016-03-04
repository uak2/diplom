class CreateStudentPeriods < ActiveRecord::Migration
  def change
    create_table :student_periods do |t|
      t.belongs_to :student, :new => true, :null => false
      t.belongs_to :term, :new => true, :null => false
      t.belongs_to :plan, :new => true, :null => false
      t.belongs_to :group, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
