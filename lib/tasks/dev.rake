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
    file = File.open("#{Rails.root}/public/avatar/user20.jpg")
    User.create(
      email: "root@example.com",
      password: "12345678",
      name: "Admin",
      introduction: FFaker::Lorem::sentence(30),
      avatar: file,
      role: "admin"
      )
    puts "admin has created"
  end


  task fake_tweet: :environment do 
    Tweet.destroy_all
    User.all.each do |user|
      rand(10).times do 
        user.tweets.create(
          description: FFaker::Lorem::sentence(15)
        )
      end
    end
    puts "create fake tweets"
  end

  task fake_like: :environment do 
    Like.destroy_all
    50.times do 
      user = User.all.sample
      tweet = Tweet.all.sample
      unless tweet.likes.create(user: user)
        return
      end
    end
    puts "create fake likes"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      followings = User.all.sample(rand(2..20))
      if followings.include?(user)
        followings.delete(user)
      end
      for following in followings
        user.followships.create!(following: following)
      end
    end
    puts "create fake following"
  end

end
