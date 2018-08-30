namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"] 
  task :rebuild => [ "dev:build", :fake_user,"db:seed", :fake_tweet, :fake_reply, :fake_like, :fake_followship]
 
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@twitter.com",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(20),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    30.times do |i|
      user = User.all.sample
      tweet = Tweet.create!(
        description: FFaker::Lorem::sentence(8),
        user: user,
        created_at: FFaker::Time::datetime
      )
    end
    puts "Total #{Tweet.count}tweets created !"
  end

  task fake_reply: :environment do
    Reply.destroy_all
      50.times do |i|
        user = User.all.sample
        tweet = Tweet.all.sample
        reply = Reply.create!(
          tweet: tweet,
          comment: FFaker::Lorem::sentence(3),
          user: user,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{Reply.count}replies created !"
  end

  task fake_like: :environment do
    Like.destroy_all
      50.times do |i|
        user = User.all.sample
        tweet = Tweet.all.sample
        like = Like.create!(
          tweet: tweet,
          user: user,
          created_at: FFaker::Time::datetime
        )
      end
    puts "Total #{Like.count}likes created !"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    users = User.all
    users.each do |user|
      2.times do |i|
        following = users.sample
        if !user.is_following?(following)
          followship = user.followships.create(following: following)
        end
      end
    end
    puts "Total #{Followship.count}followships created !"
  end

end
