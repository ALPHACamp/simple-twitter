namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
    admin_file = File.open("#{Rails.root}/public/avatar/user1.jpg")
    User.create!(
      name: "admin",
      email: "admin@admin.com",
      password: "12345678",
      introduction: FFaker::Lorem::sentence(30),
      avatar: admin_file,
      role: "admin"
    )
    puts "default admin user created"
  end
  
  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |user|
      rand(1..20).times do
        user.tweets.create(
          description: FFaker::Lorem::sentence(8)
        )
      end
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end
end
