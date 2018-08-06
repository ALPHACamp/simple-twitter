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
    User.all.each do |user|
      5.times do |i|
        user.tweets.create!(
            description: FFaker::Lorem::sentence(2),
          )
      end
      puts "have create #{Tweet.count} tweets"
    end
  end 

  task fake_reply: :environment do
    Tweet.all.each do |tweet|
      4.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample 
          )
      end
    end
    puts "have create fake replies"
    puts "now you have #{Reply.count} reply date"     
  end 

  task fake_followship: :environment do 
    User.all.each do |user|
      user.followships.destroy_all
      user.followships.create(
        following: User.all.sample
        )
    end
    puts "have create fake followships"  
    puts "now you have #{Followship.count} followships"
  end

end
