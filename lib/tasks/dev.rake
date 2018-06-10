namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    10.times do |i|
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

    User.new(
      name: "root",
      email: "root@mail.com",
      password: "123456",
      introduction: FFaker::Lorem::sentence(30),
      avatar: file,
      role: "admin"
    )
    user.save!
    puts "root"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    10.times do |i|

      tweet = Tweet.create!(
        description: FFaker::Lorem::sentence(5),
        user_id: User.all.sample.id
      )
    end
    puts "now you have #{Tweet.count} tweets data"
  end

end
