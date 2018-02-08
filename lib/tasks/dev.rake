namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.all.each do |user|
      if user.role != "admin"
        user.destroy
      end
    end

    15.times do |i|
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

    User.all.each do |user|
      rand(4).times do |i|
        tweet = Tweet.new(
          user: user,
          description: FFaker::Lorem::sentence(10)
        )

        tweet.save!
      end
    end
    puts "Finished fake tweets"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      rand(3).times do |i|
        tweet.replies.create!(
          user: User.all.sample,
          comment: FFaker::Lorem::sentence(10)
        )
      end
    end
    puts "Finished fake replies"
  end

  task fake_like: :environment do
    Like.destroy_all

    Tweet.all.each do |tweet|
      rand(5).times do |i|
        tweet.likes.create!(user: User.all.sample)
      end
    end
    puts "Finished fake likes"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      rand(5).times do |i|
        following = User.all.sample
        if user.id != following.id
          user.followships.create(following_id: following.id)
        end
      end
    end
    puts "Finished fake followships"
  end

end
