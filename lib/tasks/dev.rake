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
        email: "user#{i}@example.co",
        password: "user123",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    10.times do |i|
      tweet = Tweet.new(
        description: FFaker::Lorem::sentence(10),
        user: User.all.sample,
      )
      tweet.save!
    end
    puts "successful! Tweet: #{ Tweet.all.size }"
  end

  task fake_like: :environment do
    Like.destroy_all
    Tweet.all.each do |tweet|
      tweet.likes.create!(user: User.all.sample)
    end
    puts "successful"
  end

  task fake_follow: :environment do
    User.all.each do |user|
      user.followships.create!(following: User.where('id !=? ', user).sample)
    end
    puts "successful"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    User.all.each do |user|
      2.times do |i|
        user.replies.create!(
          tweet: Tweet.all.sample,
          comment: FFaker::Lorem::sentence(30)
        )
      end
    end
    puts "successful! Replies: #{ Reply.all.size }"
  end

end
