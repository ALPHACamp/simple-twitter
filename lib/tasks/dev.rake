namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all

    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(name: user_name,
                   email:"#{user_name}@example",
                   password: "12345678"
    )
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"

    User.create(email: "root@example.com", password: "12345678", role: "admin", name: "Dojo AC")
    puts "Default admin created!"
  end





end
