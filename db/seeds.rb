# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Default admin
ApplicationRecord.reset_column_information
admin_file = File.open("#{Rails.root}/public/avatar/user15.jpg")
admin = User.create!(email: "josh@example.com", password: "12345678", name: "josh", :role=> "admin", avatar: admin_file)
puts "Default admin created!"