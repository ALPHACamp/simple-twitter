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
    puts "Now is creating fake tweets ..."
    200.times do
      Tweet.create!(
        user_id: User.all.sample.id,
        description: FFaker::Tweet::tweet
      )
    end
    puts "have create fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    puts "Now is creating fake replies ..."
    Tweet.all.each do |tweet|
      2.times do
        tweet.replies.create!(
          user_id: User.all.sample.id,
          comment: FFaker::Tweet::tweet
        )
      end
    end
    puts "have create fake replies"
    puts "now you have #{Reply.count} replies data"
  end

  task fake_like: :environment do
    Like.destroy_all
    puts "Now is creating fake likes ..."
    User.all.each do |user|
      10.times do
        user.likes.create!(
          tweet: Tweet.all.sample,
        )
      end
    end
    puts "now you have #{Like.count} liked tweets"
  end

  task fake_following: :environment do
    Followship.destroy_all
    puts "Now is creating fake followings ..."
    User.all.each do |user|
      # 使用shuffle將陣列亂數排列，再使用pop將內容物取出，達到亂數不重複取樣的效果
      # where.not確保不會自己加自己好友
      @user = User.where.not(id: user.id).shuffle
      5.times do
        user.followships.create!(
          following: @user.pop,
        )
      end
    end
    puts "now you have #{Followship.count} followings"
  end

end
