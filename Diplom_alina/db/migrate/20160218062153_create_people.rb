class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      # У некоторых людей нет фамилии и/или отчества. Имя есть вроде у всех, потому оно не может быть пустым
      t.string :first_name, :limit => 50, :null => false
      t.string :second_name, :limit => 50
      t.string :last_name, :limit => 50
      # Все живущие на земле когда-то родились и эту дату не изменить как ни крути
      # за исключением наверно смены события отсчета времени. Но пока важней рождения Христа ничего не произошло.
      # Соответственно это послужило выносом поля из таблицы passport.
      t.datetime :birthday, :null => false
      t.timestamps null: false
    end
  end
end
