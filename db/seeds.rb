
# Default admin

User.create(email: "root@example.com", password: "123456", role: "admin", name: "root")
puts "Default admin created!"

# Default user

User.create(email: "yuyu@example.com", password: "123456", name: "yuyu")
puts "Default user created!"
