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
        email: "#{name}@example.com",
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
      3.times do
        user.tweets.create!(
          description: FFaker::Lorem::sentence(10),
          user: User.all.sample
          )
      end
    end
    puts "have created fake tweets"
    puts "have #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Tweet.all.each do |tweet|
      2.times do
        tweet.replies.create!(
          user: User.all.sample,
          comment: FFaker::Lorem.sentence
          )
      end
    end
    puts "have created fake replies"
    puts "have #{Reply.count} reply data"
  end

  task fake_like: :environment do
    Like.destroy_all
    Tweet.all.each do |tweet|
      2.times do
        tweet.likes.create!(
          user: User.all.sample
          )
      end
    end
    puts "have created fake likes"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      users = User.where.not(id: user.id).shuffle
      3.times do
        user.followships.create!(
          following: users.pop
          )
      end
    end
    puts "have created fake followship"
  end

end
