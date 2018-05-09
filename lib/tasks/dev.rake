namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    120.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{rand(1...20)}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(10),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    150.times do |i|
      tweet = Tweet.new(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
      tweet.save!
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    350.times do |i|
      reply = Reply.new(
        comment: FFaker::Lorem.sentence,
        user: User.all.sample,
        tweet: Tweet.all.sample
      )
      reply.save!
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"
  end

end
