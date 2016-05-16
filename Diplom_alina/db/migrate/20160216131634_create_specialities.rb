class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      #номер специальности, для поиска в самый раз
      t.integer :number, :new => true, :null => false
      #название специальности
      t.string :name, :null => false, :limit => 100
      # Форма обучения
      t.belongs_to :form_study, :index=> true, :null=> false

      t.timestamps null: false
    end
  end
end
