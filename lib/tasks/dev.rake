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

  task uniname_user_20: :environment do
    url = "https://uinames.com/api/?ext&region=england"
    20.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.create(
        name: data["name"],
        email: data["email"],
        password: "password",
        avatar: data["photo"],
        introduction: FFaker::Lorem::sentence(30) 
      )
      puts "created user #{user.name}"
    end
    puts "now you have #{User.count} users data"
  end

  task fake_tweets_200: :environment do
    200.times do |i|
        Tweet.create(
          description: FFaker::Tweet::body,
          user: User.all.sample
        )
    end
    puts "create random 200 fake tweets"
  end

  task fake_replies_200: :environment do
    200.times do |i|
        Reply.create(
          comment: FFaker::Lorem.sentence(50),
          tweet: Tweet.all.sample,
          user: User.all.sample
        )
    end
    puts "create random 200 fake replies"
  end

  task fake_likes_100: :environment do
    100.times do |i|
        Like.create(
          user: User.all.sample,
          tweet: Tweet.all.sample
        )
    end
    puts "create random 100 fake likes"
  end

  task fake_follows_100: :environment do
    100.times do |i|
      Followship.create(
        user: User.all.sample,
        following: User.all.sample
        )
    end
    puts "create random 100 fake follows"
  end

  task fake_all: :environment do
    Rake::Task["dev:uniname_user_20"].execute
    Rake::Task["dev:fake_tweets_200"].execute
    Rake::Task["dev:fake_replies_200"].execute
    Rake::Task["dev:fake_likes_100"].execute
    Rake::Task["dev:fake_follows_100"].execute
    
    puts "finish"
  end

  task update_followers_count: :environment do
    User.all.each do |u|
      u.followers_count!
    end
    puts "update all users followers_count"
  end

end
