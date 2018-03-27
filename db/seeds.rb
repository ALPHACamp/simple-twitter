# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tweet.destroy_all
Followship.destroy_all
Like.destroy_all
User.destroy_all
Reply.destroy_all

# Default admin
file = File.open("#{Rails.root}/public/avatar/user100.jpg")
User.create(email: "root@example.com", name: "root", password: "12345678", role: "admin", avatar: file)
puts "Default admin created!"

Tweet.create( description: "Welcome_tweet", user_id: User.ids.sample )
puts "First tweet created!"
