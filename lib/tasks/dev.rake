namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
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
      puts user.name
    end
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    
    #Create Tweet
    User.all.each do |user|
      10.times do |j|
        tweet = Tweet.new(
          user: user,
          description: FFaker::Lorem::sentence(30)
        )
      end
    end
    puts "create 10 tweet per user"

    #Create Reply
    Tweet.all.each do |tweet|
      5.times do |j|
        reply = Reply.new(
          comment: FFaker::Lorem::sentence(30),
          user: User.all.sample
        )
      end
    end
    puts "create 5 reply per tweet"


  end



end
