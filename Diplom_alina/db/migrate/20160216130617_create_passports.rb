class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      # вообще логично предположить, что серия и номер есть единое число, поделенное на серию и номер
      # при выдаче паспорта, соответственно возможно отделаться одним полем типа integer.Но пока:
      t.integer :series      #cерия
      t.string :number, :new => true      #номер может начинаться с 0, потому строка. 01234
      t.string :code_subdivision, :null=>false, :limit => 100    #код подразделения
      t.datetime :date_extradition, :null => false               #дата выдачи
      t.string :passport_issued, :null => false, :limit => 255   # кем выдан
      # возможно нужно место регистрации

      t.timestamps null: false
    end
  end
end
