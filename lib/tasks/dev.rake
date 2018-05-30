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
        password: "test123",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      3.times do |i|
        user.tweets.create!(
          description: FFaker::Lorem.sentence(10)
        )
        user.tweets_count = user.tweets.length
      end
    end
    puts "now you have #{Tweet.count} tweets"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence(5),
          user: User.all.sample
        )
      end
    end
    puts "now you have #{Reply.count} replies"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      following = User.all.sample(3)
      
      for i in 0..2
        user.followships.create!(
          following: following[i]
        )
      end
    end
    User.all.each do |user|
      user.followers_count = user.followers.length
    end
    puts "now you have #{Followship.count} followships"
  end

  task fake_like: :environment do
    Like.destroy_all
    User.all.each do |user|
      tweet = Tweet.all.sample(3)
      for i in 0..2
        user.likes.create!(
          tweet: tweet[i]
        )
        user.likes_count = user.likes.length
      end
    end
    puts "now you have #{Like.count} likes"
  end

end
