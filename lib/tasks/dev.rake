namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do

    User.destroy_all

    # Default admin
    User.create(
      name: "Max",
      email: "max@example.co",
      password: "000000",
      role: "admin",
      introduction: FFaker::Lorem::sentence(30),
    )
    puts "Default admin created!"

    20.times do |i|
      name = FFaker::Name::first_name
      # file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      # 這組路徑在 Heroku 上無法使用，同學可跳過 Heroku 上圖片顯示的問題
      # 若特別想攻克的同學可參考 Filestack 說明 => https://lighthouse.alphacamp.co/units/1110

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "000000",
        introduction: FFaker::Lorem::sentence(30),
        #avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_other: :environment do

    Tweet.destroy_all
    100.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::phrase,
        user_id: rand(User.first.id..User.last.id)
      )
    end
    puts "now you have #{Tweet.count} tweets data"

    Reply.destroy_all
    300.times do |i|
      Reply.create(
        comment: FFaker::Lorem::sentence(30),
        tweet_id: rand(Tweet.first.id..Tweet.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "now you have #{Reply.count} replys data"

    Like.destroy_all
    500.times do |i|
      Like.create(
        tweet_id: rand(Tweet.first.id..Tweet.last.id),
        user_id: rand(User.first.id..User.last.id)
        )
    end
    puts "now you have #{Like.count} likes data"

    Followship.destroy_all
    100.times do |i|
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
    puts "now you have #{Followship.count} Followship data"

    tweets = Tweet.all
    tweets.each do |tweet|
       tweet.update_count
    end
    puts "now all tweets count were ready"

    users = User.all
    users.each do |user|
       user.update_count
    end
    puts "now all users count were ready"

  end

end
