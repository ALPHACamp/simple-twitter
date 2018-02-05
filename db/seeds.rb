# Default admin
User.create!(
    name: "Jianan",
    email: "root@example.com",
    password: "12345678",
    role: "admin",
    introduction: "Sed pulvinar eleifend elit, et ultricies arcu iaculis in. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis blandit non nisi id efficitur. In commodo ipsum id ligula pretium, sed pharetra nisl ullamcorper.",
    avatar: File.open("#{Rails.root}/public/avatar/user8.jpg")
  )

puts "Default admin created!"
