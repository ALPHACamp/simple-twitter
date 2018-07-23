# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Default admin
User.create(email: "admin@test.com", name: "Admin", password: "123456", role: "admin")
puts "Default admin created!"

#Default user
User.create(email: "test@test.com", name: "Tester", password: "123456")
puts "Default test account created"