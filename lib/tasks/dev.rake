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

    50.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
    end

    puts "have created fake tweets"
  end


  task fake_like: :environment do
    Like.destroy_all

    User.all.each do |user|
      1.times do
        tweet = Tweet.all.sample
        user.likes.create!(
          tweet: tweet
        )
      end
    end

    puts "have add fake likes"
  end


  task fake_followship: :environment do
    Followship.destroy_all

    User.all.each do |user|
      1.times do
        following = User.all.sample
        user.followships.create!(
          following: following
        )
      end
    end

    puts "have add fake followships"
  end


  task fake_reply: :environment do
    Reply.destroy_all

    User.all.each do |user|
      3.times do
        tweet = Tweet.all.sample
        user.replies.create!(
          tweet: tweet,
          comment: FFaker::Lorem.sentence
        )
      end
    end

    puts "have created fake replies"
  end

end
