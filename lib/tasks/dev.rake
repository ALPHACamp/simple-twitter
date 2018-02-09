namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
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
    500.times do
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user: User.all.drop(1).sample
      )
    end
    puts "500 fake tweets created!"
  end

  task fake_reply: :environment do
    Tweet.all.each do |tweet|
      rand(1..5).times do
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.drop(1).sample
        )
      end
    end
    puts "have created random fake replies for every tweet"
    puts "now you have #{Reply.count} fake replies"
  end

end
