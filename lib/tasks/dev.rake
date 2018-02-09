namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user1: :environment do

    User.destroy_all

    # Default admin
    User.create(
      name: "Admin",
      email: "admin@example.com",
      password: "123456",
      role: "admin",
      introduction: FFaker::Lorem::sentence(30),
    )
    puts "Default admin created!"

    30.times do |i|
      name = FFaker::Name::first_name
      #file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "123456",
        introduction: FFaker::Lorem::sentence(35),
        #avatar: file
      )
      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do

    Tweet.destroy_all
    100.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::phrase,
        user_id: rand(User.first.id..User.last.id)
      )
    end
    puts "#{Tweet.count} tweets data created"

    Reply.destroy_all
    300.times do |i|
      Reply.create(
        comment: FFaker::Lorem::sentence(30),
        tweet_id: rand(Tweet.first.id..Tweet.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "#{Reply.count} replys data created"

    Like.destroy_all
    300.times do |i|
      Like.create(
        tweet_id: rand(Tweet.first.id..Tweet.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "#{Like.count} likes data created"

    Followship.destroy_all
    50.times do |i|
      Followship.create(
        user_id: rand(User.first.id..User.last.id),
        following_id: rand(User.first.id..User.last.id)
        )
    end
    followships = Followship.all
    followships.each do |followship|
      if followship.user_id == followship.following_id
        followship.destroy
      end
    end
    puts "#{Followship.count} Followship data created"


  end

end
