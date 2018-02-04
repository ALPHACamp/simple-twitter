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
        email: "user#{i}@mail.co",
        # email: "#{name}@mail.co",
        password: "000000",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweets: :environment do
    Tweet.destroy_all
    @users = User.all
    @users.each do |user|
      (rand(20)+1).times do |variable|
        user.tweets.create!(description: FFaker::Tweet.body)
      end
      puts "#{user.name} has #{user.tweets.count} tweets!"
    end
    puts "Now you have #{Tweet.count} tweets!"
  end

  task test: :environment do
  end

  #fake all data
  task fake_all: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    # Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_tweets'].execute
  end
end
