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
    User.create( email: "root@gmail.com", password: "12345678", password_confirmation:"12345678", role: "admin", 
                   name: "root", introduction: FFaker::Lorem.paragraph )
end

  task fake_tweet: :environment do
    Tweet.destroy_all
    200.times do |i|
      tweet = Tweet.new(
        description: FFaker::Lorem::sentence(8),
        user_id: User.all.sample.id,
      )

      tweet.save!
    end
    puts "200 fake tweet generated!"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      3.times do
        tweet.replies.create!(comment: FFaker::Lorem.paragraph, 
          user_id: User.all.sample.id)
      end
    end
    
    puts "3 fake reply generated for each tweet!"
  end

  task fake_followships: :environment do
    Followship.destroy_all

    User.all.each do |user|
      5.times do 
        user.followships.create(following_id: User.all.sample.id)
      end
    end
    puts "have created 100 fake follow"
    
  end

  task fake_likes: :environment do
    Like.destroy_all

    User.all.each do |user|
      20.times do 
        user.likes.create(tweet_id: Tweet.all.sample.id)
      end
    end
    puts "have created 400 fake likes"
    
  end
end
