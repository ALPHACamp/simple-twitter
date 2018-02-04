namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    admin = User.create(
        email: "admin@example.com",
        password: "admin123", 
        role: 'admin', 
        name: '管理員',
        introduction: FFaker::Lorem::sentence(30)
      )
    puts admin.name
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
  end

  task fake_tweet: :environment do
    Tweet.destroy_all    
    30.times do |i|
            
      tweet = Tweet.new(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
      tweet.save!     
    end
    puts '30 tweets have been created!'
  end

end
