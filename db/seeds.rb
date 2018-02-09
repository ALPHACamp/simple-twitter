# Default admin
# filelink = ''
# Dir.glob("#{Rails.root}/public/avatar/user8.jpg").map do |pic|
#   client = FilestackClient.new('AdXNwEl0bRuyww64RxwQNz')
#   filelink = client.upload(filepath: pic)
# end

User.create!(
    name: "Jianan",
    email: "root@example.com",
    password: "12345678",
    role: "admin",
    introduction: "Sed pulvinar eleifend elit, et ultricies arcu iaculis in. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis blandit non nisi id efficitur. In commodo ipsum id ligula pretium, sed pharetra nisl ullamcorper.",
    # avatar: filelink.url
  )

puts "Default admin created!"
