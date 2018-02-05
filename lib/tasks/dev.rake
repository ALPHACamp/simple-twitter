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

  task fake_tweets: :environment do
    Tweet.destroy_all
    100.times do |i|
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
    puts "now you have #{Reply.count} user replies"
  end 


end
