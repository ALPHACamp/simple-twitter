namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    # User.all.each do |user|
    #   user.destroy unless user.admin?
    # end

    User.destroy_all

    User.create(email: "123@gmail.com", password: "123456", role: "admin", name: "123admin")
    puts "Default admin created!"



    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/app/assets/images/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "123456",
        introduction: FFaker::Lorem::sentence(15),
        avatar: file
      )

      user.save!
      puts user.name
    end
    puts "now you have #{User.count} users data"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |user|
      3.times do |i|
         user.tweets.create!(
          description: FFaker::Lorem::sentence(10),
        )
      end
    end

    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      rand(1..4).times do |i|
         tweet.replies.create!(
          comment: FFaker::Lorem::sentence(10),
          user: User.all.sample
        )
      end
    end

    puts "now you have #{Reply.count} replies data"
  end

  task fake_like: :environment do
    Like.destroy_all

    Tweet.all.each do |tweet|
      rand(1..10).times do |i|
        tweet.likes.create!(
          user: User.all.sample
          )
      end
    end
    puts "now you have #{Like.count} likes data"
  end

  task fake_followship: :environment do 
    Followship.destroy_all

    User.all.each do |user|
      @users = User.where.not(id: user.id).shuffle  #where.not確保不會自己加自己好友
      rand(3..8).times do
        user.followships.create!(
          following: @users.pop,
        )      
      end     
    end
    puts "now you have #{Followship.count} followships data"
  end




end






