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
    15.times do |i|
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
    20.times do |i|
      user = User.all.shuffle
      Like.create!(user: user.pop, tweet: Tweet.all.sample)
    end
    puts "successful"
  end

  task fake_follow: :environment do
    Followship.destroy_all
    users = User.all
    users.each do |user|
      others = User.where.not(id: user.id).shuffle
      5.times do |i|
        user.followships.create!(following: others.pop)
      end
    end
    puts "successful"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    User.all.each do |user|
      2.times do |i|
        user.replies.create!(
          tweet: Tweet.all.sample,
          comment: FFaker::Lorem::sentence(20)
        )
      end
    end
    puts "successful! Replies: #{ Reply.all.size }"
  end

end
