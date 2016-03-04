class CreateSubdivisionGroups < ActiveRecord::Migration
  def change
    create_table :subdivision_groups do |t|
      t.belongs_to :subdivision, :new => true, :null => false
      t.belongs_to :group, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
