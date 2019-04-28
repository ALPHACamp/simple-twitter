namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all

    User.create!(
      name: "root",
      email: "root@mail.com",
      password: "123456",
      introduction: FFaker::Lorem::sentence(10),
      role: "admin"
    )
    puts "root"

    20.times do |i|
      name = FFaker::Name::first_name
      url = "https://s3-ap-northeast-1.amazonaws.com/du2-user-avatar/user#{i+1}.jpg"

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "123456",
        introduction: FFaker::Lorem::sentence(10),
        remote_avatar_url: url
      )

      user.save!
      puts user.name
    end
    
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      rand(1..7).times do |i|

        user.tweets.create!(
          description: FFaker::Lorem::sentence(10)
        )
      end
    end
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      user.followers_count = 0
      @users = User.where.not(id: user.id).shuffle  #where.not確保不會自己加自己
      rand(1..15).times do |i|
        user.followships.create!(
          following: @users.pop
        )
      end
    end
    puts "now you have #{Followship.count} followships data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Tweet.all.each do |tweet|
      rand(1..7).times do |i|
        tweet.replies.create!(
          user: User.all.sample,
          comment: FFaker::Lorem::sentence(10)
        )
      end
    end
    puts "now you have #{Reply.count} replies data"
  end

  task fake_like: :environment do
    Like.destroy_all
    Tweet.all.each do |tweet|
      rand(1..5).times do |i|
        tweet.likes.create!(
          user: User.all.sample
        )
      end
    end
    puts "now you have #{Like.count} likes data"
  end

  task fake_all: :environment do
    #Rake::Task['db:migrate'].execute
    #Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_tweet'].execute
    Rake::Task['dev:fake_followship'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_like'].execute
    #
  end
end
