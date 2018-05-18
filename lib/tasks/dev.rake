namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name.first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i + 1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: '12345678',
        introduction: FFaker::Lorem.sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task reset_replies_counters: :environment do
    Tweet.find_each{ |tweet|Tweet.reset_counters(tweet.id,:replies)}
    puts 'replies is reset count'
  end
  
  task reset_followships_counters: :environment do
  User.find_each{|user|User.reset_counters(user.id,:followships)}
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
