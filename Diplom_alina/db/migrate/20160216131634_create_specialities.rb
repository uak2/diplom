class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      #номер специальности, для поиска в самый раз
      t.integer :number, :new => true, :null => false
      #название специальности
      t.string :name, :null => false, :limit => 100
      #номер формы обучения.Возможно в модели задать константами,что ускорит выборку
      #если вдруг необходимо будет произвести поиск всех студентов на заочной форме обучения
      t.integer :form_number, :new => true, :null => false
      #название формы обучения. Очная заочная etc
      t.string :form_name, :null => false, :limit=> 100
      t.string :level_name, :null => false, :limit => 100
      t.integer :level_number, :new => true, :null => false

      t.timestamps null: false
    end
  end
end
