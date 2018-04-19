namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    filelink = "" 
      Dir.glob("#{Rails.root}/public/avatar/admin.jpg").map do |pic|
        client = FilestackClient.new('ARz3g0HLfR5i0KuobcdJmz')
        filelink = client.upload(filepath: pic)
    end    
    admin = User.create(
        email: "admin@example.com",
        password: "admin123", 
        role: 'admin', 
        name: '管理員',
        introduction: FFaker::Lorem::sentence(30), 
        avatar: filelink.url
      )
    puts admin.name
    20.times do |i|
      name = FFaker::Name::first_name
      filelink = "" 
      Dir.glob("#{Rails.root}/public/avatar/user#{i+1}.jpg").map do |pic|
        client = FilestackClient.new('ARz3g0HLfR5i0KuobcdJmz')
        filelink = client.upload(filepath: pic)
      end            
      
      user = User.create(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),                
        avatar: filelink.url      
      )
      
      user.save!
      puts user.name
          
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all    
    50.times do |i|
            
      tweet = Tweet.new(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
      tweet.save!     
    end
    puts '50 tweets have been created!'
  end

  task fake_reply: :environment do
    Reply.destroy_all    
    500.times do |i|
            
      reply = Reply.new(
        comment: FFaker::Lorem.sentence,
        user: User.all.sample,
        tweet: Tweet.all.sample
      )
      reply.save!     
    end
    puts '500 replies have been created!'
  end

  task fake_like: :environment do
    Like.destroy_all    
    500.times do |i|
            
      like = Like.new(        
        user: User.all.sample,
        tweet: Tweet.all.sample
      )
      like.save!     
    end
    puts '500 likes have been created!'
  end

  task fake_followship: :environment do
    Followship.destroy_all    
    500.times do |i|
      user = User.all.sample
      following = (User.all - [user]).sample

      Followship.create(        
        user: user,
        following: following
      )
    end
    puts '500 followship have been created!'
  end


end
