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
        introduction: FFaker::Lorem::sentence,
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do 
    Tweet.destroy_all
  
    30.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence,
        user: User.all.sample
      )
    end

    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    50.times do
      Reply.create!(
        comment: FFaker::Lorem.sentence,
        tweet: Tweet.all.sample,
        user: User.all.sample,
      )
    end

    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"

  end

  task fake_like: :environment do
    Like.destroy_all

    50.times do
      Like.create!(
        user: User.all.sample,
        tweet: Tweet.all.sample
      )
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} like data"
  end

  task fake_followship: :environment do
    Followship.destroy_all

    50.times do
      Followship.create(
        user: User.all.sample,
        following: User.all.sample
      )
    end
    puts "have created fake followships"
    puts "now you have #{Followship.count} followship data"
  end
end
