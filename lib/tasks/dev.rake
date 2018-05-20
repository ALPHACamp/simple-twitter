namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name.first_name
      file = File.open("#{Rails.root}/assets/images/avatar/user#{i + 1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: '12345678',
        introduction: FFaker::Lorem.sentence(5),
        avatar: file

      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |u|
    rand(10).times do |i|
      u.tweets.create!(
        description: FFaker::LoremCN.words(5)
      )    
      end
    end
    puts "tweets is create "
  end

  task fake_like: :environment do
   Like.destroy_all
    100.times do |i|
    Like.create!(
      tweet_id: Tweet.all.ids.sample,
      user_id: User.all.ids.sample
    )
    end
    puts "fake like is create"
  end

  task fake_followship: :environment do
  Followship.destroy_all
  User.all.each do |u|
    @users = User.where.not(id: u.id).shuffle #where.not確保不會自己加自己好友
    10.times do
    u.followships.create!(
      following: @users.pop
    )
      end
    end
    puts "fake followship is create"
  end

  task fake_reply: :environment do
  Reply.destroy_all
 
    300.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      Reply.create(
        user: user,
        tweet: tweet,
        comment: FFaker::LoremCN.words(5)
      )
    end
      puts "fake reply is create"
  end


  task reset_replies_counters: :environment do
    Tweet.find_each{ |tweet|Tweet.reset_counters(tweet.id,:replies)}
    puts 'replies is reset count'
  end
  
  task reset_followships_counters: :environment do
  User.find_each{|user|User.reset_counters(user.id,:followings)}
  puts 'followships is reset count'
  end

  task reset_followers_counters: :environment do
    User.find_each{|user|User.reset_counters(user.id,:followers)}
    puts 'followers is reset count'
    end

    task reset_tweets_counters: :environment do
    User.find_each{|user|User.reset_counters(user.id,:tweets)}
    puts 'tweets is reset count'
    end
end
