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

    # Default admin
    User.create(name: "Admin", email: "admin@example.com", password: "123456", introduction: FFaker::Lorem::sentence(30), role: "admin")
    puts "Default admin created!"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    30.times do |i|
      author = User.all.sample
      Tweet.create!(
        description: FFaker::Lorem::paragraph[1..rand(1..140)],
        user: author
      )
      author.count_tweets
    end
    puts "now there are #{Tweet.count} tweets"
  end

  task fake_reply: :environment do
    50.times do |i|
      Reply.create!(
        comment: FFaker::Lorem::paragraph[1..rand(1..140)],
        user: User.all.sample,
        tweet: Tweet.all.sample
      )
    end
    puts "now there are #{Reply.count} replies"
  end

  task fake_like: :environment do
    50.times do |i|
      post = Tweet.all.sample
      Like.create(
        user: User.all.sample,
        tweet: post
      )
      post.user.count_likes(true)
    end
    puts "now there are #{Like.count} likes"
  end  

  task fake_followship: :environment do
    60.times do |i|
      user1 = User.all.sample
      user2 = User.all.sample
      if user1 != user2
        Followship.create(
          user: user1,
          following_id: user2.id
        )
      end
    end
    puts "now there are #{Followship.count} followships"
  end
end
