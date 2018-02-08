namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  # db:reset 用來清除schema的table，並執行seeds裡面預先載入的資料
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
  end
  
  task fake_tweet: :environment do
    Tweet.destroy_all
    60.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::sentence[0..140],
        user: User.all.sample
      )
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence[1..100],
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"
  end

end