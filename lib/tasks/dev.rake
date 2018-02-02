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
    user = User.last
    user.name = "Root"
    user.email = "Root@example.co"
    user.role = "admin"
    user.save                      # 沒存都不算啊！注意
    puts user.name
    puts "now you have #{User.count} users data"
  end

  # Tweet Model 設定 description 140 字限制
  task fake_tweet: :environment do
    Tweet.destroy_all
    100.times do |i|
      tweet = Tweet.new(
        description: FFaker::Lorem::characters(character_count = 140),
        user: User.all.sample,                     # 用 user 給外鍵 user_id 資訊
      )
      tweet.save!
    end
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Tweet.all.each do |tweet|
      2.times do
        tweet.replies.create!(
          tweet: Tweet.all.sample,
          user: User.all.sample,
          comment: FFaker::Lorem::words(num = 15),
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies data"
  end

  task fake_like: :environment do
    Like.destroy_all
    Tweet.all.each do |tweet|
      3.times do
        tweet.likes.create!(
          user: User.all.sample,
          tweet: Tweet.all.sample,
        )
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} likes data"

  end

end









