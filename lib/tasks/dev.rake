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
  end

  task fake_clean_tweet: :environment do
    Tweet.destroy_all
    puts "Clean all tweets"
  end

  task fake_tweet: :environment do
      User.all.sample(6).each do |user|
        tweet = user.tweets.build(description: FFaker::Lorem.paragraph[0,138])
        tweet.save!
      end
      puts "create 6 fake tweets"
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

end
