class CreateTypeSubdivisions < ActiveRecord::Migration
  def change
    create_table :type_subdivisions do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
