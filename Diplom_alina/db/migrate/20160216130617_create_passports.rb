class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.belongs_to :person, :index => true, :null => false
      # вообще логично предположить, что серия и номер есть единое число, поделенное на серию и номер
      # при выдаче паспорта, соответственно возможно отделаться одним полем типа integer.Но пока:
      t.integer :series      #cерия
      t.string :number, :index => true      #номер может начинаться с 0, потому строка. 01234
      t.string :code_subdivision, :null=>false, :limit => 100    #код подразделения
      t.datetime :date_extradition, :null => false               #дата выдачи
      t.string :passport_issued, :null => false, :limit => 255   # кем выдан
      t.string :sex, :null => false, :default=>'m', :limit=>1    #пол по паспорту m - man. w - woman
      # возможно нужно место регистрации
      t.datetime :birthday, :null=>false
      t.string :birth_city, :null=>false

      t.string :first_name, :null=>false, :index=>true, :limit => 50
      t.string :second_name, :null=>false, :index => true, :limit => 50
      t.string :last_name, :null=>false, :index => true, :limit => 50

      t.timestamps null: false
    end
  end
end
