namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all

    # Default admin
    User.create(name: "Admin", email: "root@test.test", password: "1234321", role: "admin")
    puts "Default admin created!"
    Tweet.create(user_id: "#{User.find_by(email: "root@test.test").id}", description: "admin's tweet")
    puts "Default admin's tweet created!"

    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@test.test",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )
      user.save!

      tweet = Tweet.new(
        user_id: "#{User.find_by(name: name).id}",
        description: FFaker::Lorem::sentence(5)
      )
      tweet.save!

      reply = Reply.new(
        user_id: "#{User.find_by(name: name).id}",
        tweet_id: "#{User.find_by(email: "root@test.test").id}",
        comment: FFaker::Lorem::sentence(3)
      )
      reply.save!

      Tweet.find_by(user_id: "#{User.find_by(email: "root@test.test").id}").update(replies_count: "#{i+1}")
      puts tweet.user_id
      puts user.name
    end

  end

end
