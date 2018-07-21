# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

file = File.open("#{Rails.root}/public/avatar/user#{rand(1..20)}.jpg")
User.create(
  email: "admin@gmail.com",
  password: "123456",
  name: "Admin",
  introduction: "hello~",
  avatar: file,
  role: "admin"
)

puts "admin has created"
