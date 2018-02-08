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

  task fake_tweets: :environment do
    Tweet.destroy_all

    150.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
    end
    puts "totally #{Tweet.count} are created"
  end

  task fake_replies: :environment do
    Reply.destroy_all

    200.times do |i|
      Reply.create!(
        comment: FFaker::Lorem.sentence,
        tweet: Tweet.all.sample,
        user: User.all.sample
      )
    end
    puts "totally #{Reply.count} are created"
  end

  task fake_follows: :environment do
    Followship.destroy_all

    User.all.each do |user| 
      10.times do |i|
        following = User.all.sample
        if not user.following?(following)
          user.followships.create!(
            following: following
          )
        end
      end
      puts "#{Followship.count} followships have been created"
    end
  end

end
