# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

file = File.open("#{Rails.root}/public/avatar/user#{rand(1..20)}.jpg")
 User.create(
   email: "root@example.com",
   password: "12345678",
   name: "Duncan",
   introduction: "Administrator",
   avatar: file,
   role: "admin"
 )
 puts "admin has created"

 User.create(email: "user1@example.com", password: "12345678", name: "user1", introduction: "user1", avatar: "", role: "")
 User.create(email: "user2@example.com", password: "12345678", name: "user2", introduction: "user2", avatar: "", role: "")
 User.create(email: "user3@example.com", password: "12345678", name: "user3", introduction: "user3", avatar: "", role: "")
 puts "user123 has created"
