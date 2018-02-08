#Default admin
User.destroy_all
User.create(email: "root@example.com", password:"1qaz2wsx", role: "admin", name: "admin")

puts "Default admin created!"