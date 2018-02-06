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
      user.save!
      # puts user.name
    end
    puts "20 個使用者已創建"
    
    Tweet.destroy_all
    100.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user_id: User.all.sample.id
        )
    end
    puts "100 個 Tweets 已創建"
    
  end
  
  
end
