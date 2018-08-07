namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    User.create(email: "root@example.com", password: "12345678", role: "admin", name: "root")
    puts "Default admin created!"
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
    User.all.each do |user|
      3.times do |i|
        user.tweets.create!(
          description: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "create tweets"
    puts "#{Tweet.count} tweet data"
  end


end
