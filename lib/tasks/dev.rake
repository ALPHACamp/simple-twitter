namespace :dev do
  # 請先執行 rails dev:fake，可以產生 20 個資料完整的 User 紀錄
  task fake: :environment do
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
      
      if i == 0
        user.role = "admin"
      end
      
      user.save!
      # puts user.name
    end
    puts "20 個使用者已創建"
    
    Tweet.destroy_all
    30.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user_id: User.all.sample.id
        )
    end
    puts "30 個 Tweets 已創建"
    
    Reply.destroy_all
    30.times do |i|
      Reply.create!(
        comment: "這是有的沒的回覆",
        user_id: User.all.sample.id,
        tweet_id: Tweet.all.sample.id
        )
    end
    puts "30 個 Replies 已創建"
    
    
    
  end
  
  
end
