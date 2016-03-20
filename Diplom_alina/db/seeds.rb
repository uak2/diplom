# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


roles = Role.create([{:role_number => 0, :role_title=>'Деканат'},{:role_number => 1, :role_title=>'Секретарь'} ])

user = User.new
user.login="Alina"
user.password = "AlinaAlina"
user.roles=roles
user.save

