namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      number = rand(5..30)

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(number),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do 
    Tweet.destroy_all
  
    30.times do |i|
      number = rand(2..8) 
      Tweet.create!(
        description: FFaker::Lorem.sentence(number),
        user: User.all.sample
      )
    end

    puts "have created fake tweet"
    puts "now you have #{Tweet.count} comment data"
  end

end
