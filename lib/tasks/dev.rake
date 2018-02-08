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
    User.all.each do |i|

      rand(6).times do |j|
        tweet = Tweet.new(
          user: i,
          description: FFaker::Lorem::sentence(10)
        )

        tweet.save!
      end
    end
    puts "Finished!"
  end

  tast fake_online_user: :environment do
    User.all.each do |i|
      if i.role != "admin"
        i.destroy
      end
    end

    url = "https://uinames.com/api/?ext&region=england"

    20.times do |i|
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.create!(
        name: data["name"],
        email: data["email"],
        password: "123456",
        introduction: FFaker::Lorem::sentence(30),
        avatar: data["photo"]
      )

      puts "created user #{user.name}"
    end

    puts "created #{User.count} users"
  end

end
