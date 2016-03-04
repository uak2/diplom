class CreateSubdivisions < ActiveRecord::Migration
  def change
    # Подразделение
    create_table :subdivisions do |t|
      #для удобного писка и индексирования сделаны двойные поля типа
      # type_number и type_name.
      t.integer :type_number, :new => true, :null => false
      t.string :type_title, :limit=>100
      # нужно ли будет производить по этим полям поиск???
      t.string :institution, :null => false, :limit => 255   # Название института
      t.string :chairisting, :null=> false, :limit => 255    #кафедра
      t.timestamps null: false
    end
  end
end
