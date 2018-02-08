# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
file = File.open("#{Rails.root}/app/assets/images/tweets.png")

User.create(email: "iiiii@is", password: "123456", role: "admin", name: "root", avatar:file , introduction:"HI,I'm admin")
puts "Default admin created!"
