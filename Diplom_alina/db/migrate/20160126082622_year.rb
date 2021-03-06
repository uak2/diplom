class Year < ActiveRecord::Migration
  def change
  create_table :years do |t|
    #Если нужно хранить именно год, то лучше число. Сейчас тип данных дата, так как
    # ее можно расспарсить и получить нужный год. Дату оставляю для возможных изменений.
    t.datetime :start_year, :null => false
    t.datetime :end_year, :null => false
    end
  end
end
