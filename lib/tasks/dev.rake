namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    # User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name

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
    50.times do |i|
      tweet = Tweet.new(
        description: FFaker::Lorem::sentence(10),
        user_id: User.all.sample.id
      )
      user = tweet.user.increment(:tweets_count, 1)
      user.save!
      tweet.save!
    end
    puts "have create 50 tweets"
  end

  task fake_replies: :environment do
    tweets = Tweet.all
    tweets.each do |tweet|
      rand(0..3).times do |i|
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
    100.times do |i|
      Like.create!(
        user_id: User.all.sample.id,
        tweet_id: Tweet.all.sample.id
      )
    end
    puts "create fake 100 likes!"
  end

  task fake_follow: :environment do
    users = User.all
    users.each do |user|
      followings = User.all.sample(rand(0..10))
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
