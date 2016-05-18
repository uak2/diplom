AccessPermission.create([{id: 1, :note=>'Показывать в меню \'Направления/Специальности\''},
                         {id: 2, :note=>'Показывать в меню \'Группы/Подразделения\''},
                         {id: 3, :note=>'Показывать в меню \'Учебные промежутки\''},
                         {id: 4, :note=>'Показывать в меню \'Пользователи системы\''}])

role_1 = Role.new({:role_title=>'Деканат'})
role_2 = Role.new({:role_title=>'Секретарь'})
role_3 = Role.new({:role_title=>'Администратор'})

role_1.access_permissions = AccessPermission.where(id: [1, 2, 3]).load
role_2.access_permissions = AccessPermission.where(id:1).load
role_3.access_permissions = AccessPermission.all

role_1.save
role_2.save
role_3.save

user = User.new
user.login = 'Alina'
user.password = 'AlinaAlina'
user.roles = Role.all
user.save

FormStudy.create([{:name=>'Очное'}, {:name=>'Заочное'}, {:name=>'Удаленное'}])

