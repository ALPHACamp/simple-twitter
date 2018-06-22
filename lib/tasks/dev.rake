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

  task fake_tweets: :environment do
    50.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::sentence(10),
        user_id: User.all.sample.id
        )
    end

    puts "have create fake tweets"
    puts "now you have #{Tweet.count} tweets"
  end

  task fake_replies: :environment do
    Tweet.all.each do |tweet|
      3.times do |i|
        Reply.create!(
          comment:FFaker::Lorem::sentence(10),
          user_id: User.all.sample.id,
          tweet_id: tweet.id
        )
      end
    end
    puts "have create fake replies"
    puts "now you have #{Reply.count} tweets"
  end


  task fake_follows: :environment do
    users = User.all.each do |user|
      followings = User.all.sample(5)
      followings.each do |following|
        if(following != user)
          Followship.create!(
            user_id: user.id,
            following_id: following.id
          )
          puts "have create fake followings"
          puts "now you have created followship #{user.name} and #{following.name}"
        end
      end
    end
  end

end  
