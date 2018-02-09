namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    users = User.all
    users.each do |user|
      if !user.admin? && user.name != "User"
        user.destroy
      end
    end

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
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    200.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::sentence(10),
        user_id: User.all.sample.id
        )
    end 
    puts "Now you have #{Tweet.count} fake tweets" 
  end  

  task fake_reply: :environment do
    Reply.destroy_all
    puts "creating fake replies..."    
    Tweet.all.each do |r|
     3.times do
       r.replies.create!(comment: FFaker::Lorem::sentence(5),
        tweet_id: r.id,
        user: User.all.sample,
       )      
     end     
    end
    puts "now you have #{Reply.count} replies"
  end 

  task fake_like: :environment do
    Like.destroy_all
    puts "creating fake likes..."
    User.all.each do |u|
     @tweets = Tweet.all.sample(5) 
     5.times do
       u.likes.create!(
        tweet: @tweets.pop,
       )      
     end     
    end
    puts "now you have #{Like.count} liked tweets"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    puts "creating fake followship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      6.times do
        u.followships.create!(
        following: @users.pop,
        )        
      end 
      u.count_followers    
    end
    puts "now you have #{Followship.count} followship"
  end

  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_tweet'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_like'].execute
    Rake::Task['dev:fake_followship'].execute
  end

end
