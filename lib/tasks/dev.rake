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
        #avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_admin: :environment do
    # 製造假Admin
    User.create!(
      name: "homer",
      email: "admin@example.com",
      password: "123456",
      introduction: "Doh! Doh! Doh! Doh! Doh! Doh!",
      #avatar: File.open("#{Rails.root}/public/avatar/admin.png"),
      role: "admin"
    )
    puts "Admin Homer created!"
  end

  task set_fake_avatars: :environment do
    User.find(1).update(avatar: "https://cdn.filestackcontent.com/EFNFldaVSMyi9Zk3uJoJ")
    User.find(2).update(avatar: "https://cdn.filestackcontent.com/x25ImlgLQjiOJzGjhQVI")
    User.find(3).update(avatar: "https://cdn.filestackcontent.com/OvLwpGAhTIee3ATWvhZF")
    User.find(4).update(avatar: "https://cdn.filestackcontent.com/SLWv5iHBT3y54IQyC6ei")
    User.find(5).update(avatar: "https://cdn.filestackcontent.com/6156gf8SnKtse88EkvjA")
    User.find(6).update(avatar: "https://cdn.filestackcontent.com/8QdkA1e4SqaerEehBm8A")
    User.find(7).update(avatar: "https://cdn.filestackcontent.com/NgoFmfu4RtuqGHodjmS6")
    User.find(8).update(avatar: "https://cdn.filestackcontent.com/tWCts2QKR2CEvzcQvsFl")
    User.find(9).update(avatar: "https://cdn.filestackcontent.com/n2FNXS1fRuOu3qhSEruF")
    User.find(10).update(avatar: "https://cdn.filestackcontent.com/Bh9OZUWhQHiBFl5kpFG0")
    User.find(11).update(avatar: "https://cdn.filestackcontent.com/CaCgFrNSi21cDvEFiVfe")
    User.find(12).update(avatar: "https://cdn.filestackcontent.com/zUMVqdDEQqeeIhQZDy5g")
    User.find(13).update(avatar: "https://cdn.filestackcontent.com/PGUCGAn7Sgq9jCUtMu8s")
    User.find(14).update(avatar: "https://cdn.filestackcontent.com/soVjhLrbTKmAEcRuB5YQ")
    User.find(15).update(avatar: "https://cdn.filestackcontent.com/oY56ETZ0SICrezTFv1hA")
    User.find(16).update(avatar: "https://cdn.filestackcontent.com/YnimFWyXR5mStxxBiMrP")
    User.find(17).update(avatar: "https://cdn.filestackcontent.com/ClbS56KhTI6mnBFOAHMM")
    User.find(18).update(avatar: "https://cdn.filestackcontent.com/POf9zfl0QMy2puPtQRvS")
    User.find(19).update(avatar: "https://cdn.filestackcontent.com/L9goPhWTb6FmQl8XHJ2f")
    User.find(20).update(avatar: "https://cdn.filestackcontent.com/N3PQpJW9RQOaQ81sgo3V")
    User.find(21).update(avatar: "https://cdn.filestackcontent.com/4rWsXje4QRKXNAXygM9h")
  end

  task fake_others: :environment do
    Rake::Task['dev:fake_tweet'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_like'].execute
    Rake::Task['dev:fake_followship'].execute
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
    Like.destroy_all
    500.times do
      user = User.all.sample
      tweet = Tweet.all.sample
      unless tweet.likes.create(user: user)
        return
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} like data"
  end

  #製造假followship
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