# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
file = File.open("#{Rails.root}/public/avatar/admin.png")

User.create(
  name: "Admin",
  email: "admin@example.com",
  password: "12345678",
  introduction: FFaker::Lorem::sentence(30),
  avatar: file,
  role: "admin"
  )
puts "Default admin created!"