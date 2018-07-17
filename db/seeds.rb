# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tweet.destroy_all
User.destroy_all

20.times do |i|
  user_name = FFaker::Name.first_name
  User.create!(
    name: user_name,
    email: "#{user_name}@example.com",
    password: "12345678",
    introduction: FFaker::Lorem.phrase
  )
end
puts "have created fake users"
puts "now you have #{User.count} users data"


User.all.each do |user|
  3.times do |i|
    user.tweets.create!(
      description: FFaker::Tweet.body
    )
  end
end
puts "have created fake tweets"
puts "now you have #{Tweet.count} comment data"

User.create(
  name: "admin",
  email: "root@admin.com",
  password: "12345678",
  role: "admin",
  introduction: FFaker::Lorem.phrase	
)
puts "Default admin created!"
