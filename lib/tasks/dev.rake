namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  # db:reset 用來清除schema的table，並執行seeds裡面預先載入的資料
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

  #製造假Admin
  task fake_admin: :environment do
    User.create!(
      name: "homer",
      email: "admin@example.com",
      password: "123456",
      introduction: "Doh! Doh! Doh! Doh! Doh! Doh!",
      avatar: File.open("#{Rails.root}/public/avatar/admin.png"),
      role: "admin"
    )
    puts "Admin Homer created!"
  end
  
  #製造假tweet
  task fake_tweet: :environment do
    Tweet.destroy_all
    60.times do |i|
      Tweet.create!(
        description: FFaker::Lorem::sentence[0..140],
        user: User.all.sample
      )
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweet data"
  end

  #製造假reply
  task fake_reply: :environment do
    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence[1..100],
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} reply data"
  end

  #製造假like
  task fake_like: :environment do
    Tweet.all.each do |tweet|
      rand(1..3).times do |i|
        tweet.likes.create!(
          user: User.all.sample
        )
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} like data"
  end

  #製造假followship，我花了6小才做出來
  task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      15.times do |i|
        followed = User.all.sample 
        unless user.id == followed.id or Followship.all.where(:user_id => user.id).pluck(:following_id).include? followed.id
          user.followships.create!(
            following: followed
          )
        end
      end
    end
    puts "have created fake followships"
    puts "now you have #{Followship.count} followships data"
  end
end