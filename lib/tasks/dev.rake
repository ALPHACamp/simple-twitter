namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.all.each do | user |
      user.destroy unless user.admin?
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


  # 產生80筆Tweet  
  task fake_tweet: :environment do
    Tweet.destroy_all

    80.times do |i|
      Tweet.create!(
        user: User.all.sample,
        description: FFaker::Tweet.tweet
      )
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end


  # 每筆Tweet產生3則reply
  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample
          )
      end
    end
    puts "Have created fake replies."
    puts "Now you have #{Reply.count} reply data."


  end

end
