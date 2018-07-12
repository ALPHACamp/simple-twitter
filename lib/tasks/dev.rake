namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    user = User.create(
      name: "Yedda",
      email: "yedda@yedda.com",
      password: "yeddaa",
      introduction: "I am Yedda. I am a IC designer. I am learning how to be a full-stack web engineer",
      role: "admin"
    )

    19.times do |i|
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

    puts "have created fake users"
    puts "now you have #{User.count} users data (#{User.first.id} ~ #{User.last.id})"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |user|
      rand(30).times do |i|
        user.tweets.create(
          description: FFaker::Lorem::sentence(20),
          created_at: rand(1000).minutes.ago
        )
      end
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data (#{Tweet.first.id} ~ #{Tweet.last.id})"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      rand(20).times do |i|
        tweet.replies.create(
          comment: FFaker::Lorem::sentence(20),
          user: User.all.sample,
          created_at: tweet.created_at + rand(1000).minutes
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies data (#{Reply.first.id} ~ #{Reply.last.id})"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      rand(User.count).times do |i|
        following = User.all.sample
        # user.followships.create!(
        #   following_id: following.id
        # )
        Followship.create(
          user: user,
          following_id: following.id,
          created_at: rand(1000).minutes.ago
        )
      end
    end
    puts "have created fake followships"
    puts "now you have #{Followship.count} followships data (#{Followship.first.id} ~ #{Followship.last.id})"
  end

  task fake_like: :environment do
    Like.destroy_all

    Tweet.all.each do |tweet|
      rand(User.count).times do |i|
        user = User.all.sample
        if !tweet.is_liked?(user)        
          tweet.likes.create(
            user: user,
            created_at: Tweet.created_at + rand(1000).minutes
          )
        end
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} likes data (#{Like.first.id} ~ #{Like.last.id})"
  end

  task fake_all: :environment do
    puts "fake_user processing..."
    Rake::Task['dev:fake_user'].execute
    puts "fake_tweet processing..."
    Rake::Task['dev:fake_tweet'].execute
    puts "fake_reply processing..."
    Rake::Task['dev:fake_reply'].execute
    puts "fake_follow processing..."
    Rake::Task['dev:fake_follow'].execute
    puts "fake_like processing..."
    Rake::Task['dev:fake_like'].execute
    #看還有甚麼fake都能放進來
  end
end
