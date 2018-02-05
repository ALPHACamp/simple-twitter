namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    url = "https://uinames.com/api/?ext&region=england&amount=20"
    response = RestClient.get(url)
    data = JSON.parse(response.body)
    20.times do |i|
      user = User.new(
        name: data[i]["name"] + "#{i}",
        email: data[i]["email"],
        password: data[i]["password"],
        introduction: FFaker::Lorem::sentence(30),
        avatar: data[i]["photo"]
      )

      user.save!
      puts user.name
    end

    User.create(
      email: "admin@well.com",
      password: "123456",
      name: "Admin",
      introduction: FFaker::Lorem::sentence(30),
      avatar: "https://uinames.com/api/photos/male/3.jpg",
      role: "admin"
      )
    puts "admin has created"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      rand(20).times do
        user.tweets.create(
          description: FFaker::Lorem::sentence(8)
        )
      end
    end
    puts "create fake tweets"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    300.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      Reply.create(
        user: user,
        tweet: tweet,
        comment: FFaker::Lorem::sentence(8)
      )
    end
    puts "create fake replies"
  end

  task fake_like: :environment do
    Like.destroy_all
    500.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      tweet.likes.create(user: user)
    end
    puts "create fake likes"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      followings = User.all.sample(rand(1..20))
      for following in followings
        user.followships.create!(following: following)
      end
    end
    puts "create fake_follow"
  end

end
