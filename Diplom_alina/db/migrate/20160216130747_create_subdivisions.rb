class CreateSubdivisions < ActiveRecord::Migration
  def change
    # Подразделение
    create_table :subdivisions do |t|
      #для удобного писка и индексирования сделаны двойные поля типа
      t.belongs_to :type_subdivision, :index => true, :null => false
      # нужно ли будет производить по этим полям поиск???
      t.string :institution, :null => false, :limit => 255   # Название института
      t.string :chairisting, :null=> false, :limit => 255    #кафедра
      t.timestamps null: false
    end
  end
end
