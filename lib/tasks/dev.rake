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
        email: "#{name}_#{i}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_clean_tweet: :environment do
    Tweet.destroy_all
    puts "Clean all tweets"
  end

  task fake_tweet: :environment do
      User.all.sample(8).each do |user|
        tweet = user.tweets.build(description: FFaker::Lorem.paragraph[0,138])
        tweet.save!
      end
      puts "create 8 fake tweets"
  end

  task fake_clean_followship: :environment do
    Followship.destroy_all
    puts "Clean all tweets"
  end

  task fake_followship: :environment do
    User.all.each do |user|
      User.all.sample(5).each do |following|
        if user != following
          unless user.following?(following)
            followship = user.followships.build(following_id: following.id)
            followship.save!
          end
        end
      end
    end
    puts "create some fake followships"
  end

  task fake_clean_like: :environment do
    Like.destroy_all
    puts "Clean all likes"
  end

  task fake_like: :environment do
    i = 0
    User.all.each do |user|
      i = i +1
      num = i % 5
      num = 6-num
      Tweet.all.sample(num).each do |tweet|
        unless user.like?(tweet)
            tweet.likes.create(user: user)
        end
      end
    end
    puts "create some fake likes"
  end

  task fake_clean_reply: :environment do
    Reply.destroy_all
    puts "Clean all replies"
  end


  task fake_reply: :environment do
    User.all.each do |user|
      Tweet.all.sample(8).each do |tweet|
        tweet.replies.create(user: user, comment: FFaker::Lorem.paragraph[0,60])
      end
    end
    puts "create some fake replies"
  end

end
