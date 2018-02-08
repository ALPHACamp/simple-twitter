namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      # 這組路徑在 Heroku 上無法使用，同學可跳過 Heroku 上圖片顯示的問題
      # 若特別想攻克的同學可參考 Filestack 說明 => https://lighthouse.alphacamp.co/units/1110
      
      user = User.new(
        # name: name,
        name: "user#{i}",
        email: "user#{i}@mail.co",
        password: "000000",
        # email: "#{name}@mail.co",
        # password: "123456",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweets: :environment do
    Tweet.destroy_all
    @users = User.all
    @users.each do |user|
      # (rand(20)+1).times do |variable|
      #   user.tweets.create!(description: FFaker::Tweet.body)
      # end
      (user.id+1).times do |i|
        user.tweets.create!(description: "user#{user.id}, tweet#{i}")
      end
      puts "#{user.name} has #{user.tweets.count} tweets!"
    end
    puts "Now you have #{Tweet.count} tweets!"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    @tweets = Tweet.all
    @tweets.each do |tweet|
      3.times do |variable|
        tweet.replies.create!(comment: FFaker::Tweet.body,
          user: User.all.sample)
      end
    end
    puts "Now you have #{Reply.count} replies!"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    puts "creating fake followship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      (rand(20)).times do
        u.followships.create!(
        following: @users.pop,
        )      
      end 
      # (u.id+1).times do |i|
      #   Followship.create(following: u, user: @users.pop)
      # end   
      # puts "#{u.name} has #{u.followers_count} followers!" 
    end
    puts "now you have #{Followship.count} followship"
  end

  #fake like
  task fake_like: :environment do
    Like.destroy_all
    puts "creating fake likes..." 
    User.all.each do |u|
     5.times do
       u.likes.create!(
        tweet: Tweet.all.sample,
       )      
     end     
    end
    puts "now you have #{Like.count} liked tweets"
  end

  task test: :environment do
    @users = User.all
    @users.each do |user|
      puts "#{user.id} #{user.name}"
    end
  end

  #fake all data
  task fake_all: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_tweets'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_followship'].execute
    Rake::Task['dev:fake_like'].execute
    # Rake::Task['db:seed'].execute
  end
end
