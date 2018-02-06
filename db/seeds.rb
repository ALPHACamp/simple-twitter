# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Default user: admin and guest
User.create(
  email: "admin@mail.co",
  name: "=BOSS=",
  password: "000000",
  introduction: "Who's your daddy!",
  role: "admin"
)