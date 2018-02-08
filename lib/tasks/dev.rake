namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      client = FilestackClient.new('AUiYc1YfFRfRL04YG22igz')
      filelink = client.upload(filepath: file, multipart: false)

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: filelink.url
      )

      user.save!
      puts user.name
    end
    admin_file = File.open("#{Rails.root}/public/avatar/admin.jpg")
    client = FilestackClient.new('AUiYc1YfFRfRL04YG22igz')
    filelink = client.upload(filepath: admin_file, multipart: false)

    User.create!(
      name: "admin",
      email: "admin@admin.com",
      password: "12345678",
      introduction: FFaker::Lorem::sentence(30),
      avatar: filelink.url,
      role: "admin"
    )
    puts "default admin user created"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |user|
      rand(1..20).times do
        user.tweets.create(
          description: FFaker::Lorem::sentence(8)
        )
      end
    end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      rand(1..10).times do
        tweet.replies.create(
          comment: FFaker::Lorem::sentence(20),
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies data"
  end

  task fake_following: :environment do
    Followship.destroy_all

    User.all.each do |user|
      rand(1..10).times do
        user.followships.create(
          following_id: User.where.not(id: user.id).sample.id
        )
      end
    end
    puts "have created fake followings"
    puts "now you have #{Followship.count} followings data"
  end

  task fake_like: :environment do
    Like.destroy_all

    Tweet.all.each do |tweet|
      rand(1..5).times do
        tweet.likes.create(
          user: User.all.sample
        )
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} likes data"
  end
end
