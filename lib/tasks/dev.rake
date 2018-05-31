namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    5.times do |i|
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
    Tweet.destroy_all
    
    #Create Tweet
    User.all.each do |user|
      2.times do |j|
        tweet = Tweet.new(
          user: user,
          description: FFaker::Lorem::sentence(3)#,
          #create_at: FFaker::Time
        )
        tweet.save!
      end
    end
    puts "create 2 tweet per user"

    Reply.destroy_all
    #Create Reply
    Tweet.all.each do |tweet|
      5.times do |j|
        reply = Reply.new(
          tweet: tweet,
          comment: FFaker::Lorem::sentence(1),
          user: User.all.sample#,
          #create_at: FFaker::Time
        )
        reply.save!
      end
    end
    puts "create 5 reply per tweet"


  end


  task fake_follow: :environment do

      Followship.destroy_all
      User.all.each do |user|
        1.times do |i|
          follow = Followship.new(
              user: user,
              following: User.all.except(user).sample
            )
            follow.save!
        end
      end
      puts "create 1 follower per user"
  end


end
