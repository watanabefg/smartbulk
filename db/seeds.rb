# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
24.times do |i|
  Record.create(user_id:1, weight:44, fatPer: 18)
  Record.create(user_id:1, weight:47, fatPer: 19)
  Record.create(user_id:1, weight:46, fatPer: 18)
  Record.create(user_id:1, weight:48, fatPer: 20)
  Record.create(user_id:1, weight:50, fatPer: 21)
  Record.create(user_id:1, weight:48, fatPer: 19)
end