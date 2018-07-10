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


  task fake_tweet: :environment do
    User.all.each do |user|
      2.times do |i|
        user.tweets.create!(
          description: FFaker::Lorem.sentence,
          user: User.all.sample
        )
        #user.tweets_count=user.tweets.count
        user.save
      end
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    Tweet.all.each do |tweet|
      2.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"
  end

  task fake_like: :environment do
    Tweet.all.each do |tweet|
      2.times do |i|
        tweet.likes.create!(
          user: User.all.sample
        )
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} like data"
  end 

  task fake_follow: :environment do
    20.times do |i|
      fler=User.all.sample
      fling=User.all.sample
      Followship.create(user_id:fler.id, following_id:fling.id)
    end
    puts "have created fake followships"
    puts "now you have #{Followship.count} followship data"
  end

  task counter: :environment do
    User.all.each do |user|
        #user.tweets_count=user.tweets.count
        user.followers_count=user.followers.count
        user.save
    end
    puts "have counted tweets and followers"
  end

end