class CreateFormStudies < ActiveRecord::Migration
  def change
    create_table :form_studies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
