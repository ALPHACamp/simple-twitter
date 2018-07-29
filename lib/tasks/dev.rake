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
     
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"

    User.create(email: "root@example.com", password: "12345678", role: "admin", name: "Dojo AC")
    puts "Default admin created!"
  end

  task fake_tweets: :environment do
    Tweet.destroy_all()
     100.times do |i|
      Tweet.create!(
        description: FFaker::Lorem.sentence(5),
        user: User.all.sample
      )
    end
    puts "now you have #{Tweet.count} are created"
  end

  task fake_replies: :environment do
    Reply.destroy_all()
     178.times do |i|
      Reply.create!(
        comment: FFaker::Lorem.sentence(30),
        tweet: Tweet.all.sample,
        user: User.all.sample
      )
    end
    puts "now you have #{Reply.count} are created"
  end

  task fake_all: :environment do
    Rake::Task["db:migrate"].execute
    Rake::Task["db:seed"].execute
    Rake::Task["dev:fake_user"].execute
    Rake::Task["dev:fake_tweets"].execute
    Rake::Task["dev:fake_replies"].execute
  end





end
