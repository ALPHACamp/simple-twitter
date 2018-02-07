namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.all.each do |user|
      user.destroy unless user.admin?
    end

    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "123456",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
    puts "now you have #{User.count} users data"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |user|
      3.times do |i|
         user.tweets.create!(
          description: FFaker::Lorem::sentence(10),
        )
      end
    end

    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      2.times do |i|
         tweet.replies.create!(
          comment: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
    end

    puts "now you have #{Reply.count} replies data"
  end
end


