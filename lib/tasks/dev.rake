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
    file = File.open("#{Rails.root}/public/avatar/user21.png")
    User.create(
      email: "admin@mail.com",
      password: "admin@mail.com",
      name: "Admin",
      introduction: FFaker::Lorem::sentence(30),
      avatar: file,
      role: "admin"
    )
    puts "create user admin"
  end

  task fake_tweet: :environment do 
    Tweet.destroy_all
    User.all.each do |user|
      rand(3).times do 
        user.tweets.create(
          description: FFaker::Lorem::sentence(10)
        )
      end
    end
    puts "create tweets"
  end

end
