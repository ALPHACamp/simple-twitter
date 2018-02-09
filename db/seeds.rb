# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

# Default admin
User.create(
  id: "1",
  name:"Tony", 
  email: "qwe@qwe.qwe", 
  password: "qweqwe", 
  role: "admin", 
  introduction: "This is gourmet.",
  avatar: File.open("#{Rails.root}/public/avatar/user#{8}.jpg"))
puts "Default admin created!"


#Default user
User.create(
  id: "2",
  name:"Acow", 
  email: "123@123.123", 
  password: "123123", 
  role: "normal", 
  introduction: "Just do it!",
  avatar: File.open("#{Rails.root}/public/avatar/user#{4}.jpg"))
puts "Default user created!"


