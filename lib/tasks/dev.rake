namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    #User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name

      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      # 這組路徑在 Heroku 上無法使用，同學可跳過 Heroku 上圖片顯示的問題
      # 若特別想攻克的同學可參考 Filestack 說明 => https://lighthouse.alphacamp.co/units/1110      

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

  task fake_tweets: :environment do
    500.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::sentence(10),
        user_id: User.all.sample.id)
    end

    puts "have create fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_replies: :environment do
    tweets = Tweet.all
    tweets.each do |tweet|
      3.times do |i|
        Reply.create!(
          comment:FFaker::Lorem::sentence(10),
          user_id: User.all.sample.id,
          tweet_id: tweet.id
        )
      end
    end
    puts "create fake replies"
  end

  task fake_likes: :environment do
    1000.times do |i|
      Like.create!(
        user_id: User.all.sample.id,
        tweet_id: Tweet.all.sample.id
      )
    end
    puts "create fake 1000 likes!"
  end
  task fake_follow: :environment do
    users = User.all
    users.each do |user|
      followings = User.all.sample(10)
      followings.each do |following|
        if(following != user)
          Followship.create!(
            user_id: user.id,
            following_id: following.id
          )
          puts "create followship #{user.name} and #{following.name}"
        end
      end
    end

  end
end
