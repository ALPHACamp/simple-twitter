namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/app/assets/images/avatar/user#{i+1}.jpg")

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
    puts " #{User.count} User data"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all
    puts " create fake tweet data ..."

    100.times do |i|
      Tweet.create!(description: FFaker::Lorem.paragraph[1..140],
        user: User.all.sample
      )
    end
    puts " #{Tweet.count} tweet data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    puts " create fake Reply data ..."
    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts " #{Reply.count} Reply data"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    puts " create fake Followship data ..."
    User.all.each do |user|
      @users = User.where.not(id: user.id).shuffle
      3.times do
        user.followships.create!(
          following: @users.pop,
        )      
      end 
    end
    puts " #{Followship.count} Followship data"
  end

  # like
  task fake_like: :environment do
    Like.destroy_all
    puts " create fake like data..." 
    User.all.each do |user|
      5.times do
      user.likes.create!(
        tweet: Tweet.all.sample,
        )      
      end     
    end
    puts " #{Like.count} liked tweets"
  end  

  task fake_all: :environment do
    # Rake::Task['db:drop'].execute
    #Rake::Task['db:migrate'].execute
    #Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_tweet'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_followship'].execute
    Rake::Task['dev:fake_like'].execute
  end

  task fake_clean: :environment do
    Like.destroy_all
    Followship.destroy_all
    Reply.destroy_all
    Tweet.destroy_all
    User.destroy_all
  end
end
