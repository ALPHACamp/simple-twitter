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

    @users = User.all

    30.times do |i|

      Tweet.create!(
        description: FFaker::BaconIpsum::sentence,
        user_id: @users.sample.id
        )
    end

    puts "Now you have #{Tweet.count} tweets fake tweets data!"
  end

  task fake_reply: :environment do

    @users = User.all
    @tweets = Tweet.all

    60.times do
      
      Reply.create!(
        comment: FFaker::BaconIpsum::sentence,
        tweet_id: @tweets.sample.id,
        user_id: @users.sample.id
        )

    end

    puts "Now you have #{Reply.count} fake replies data!"
  end

  task fake_like: :environment do

    @users = User.all
    @tweets = Tweet.all

    60.times do

      @user = @users.sample
      @tweet = @tweets.sample
      Like.create!(
        user_id: @user.id,
        tweet_id: @tweet.id
        )
      @tweet.likes_count = @tweet.likes.size
      @tweet.save!

    end

    puts "Now you have #{Like.count} fake likes data!"
  end

  task fake_followship: :environment do

    @users = User.all
    @users1 = User.all.sample(10)
    @users2 = @users - @users1

    @users1.each do |user1|
      
      @user2 = @users2.sample

      Followship.create!(
        user_id: user1.id,
        following_id: @user2.id
        )

      @user2.followers_count = @user2.followers.size
      @user2.save!


      puts "created followship: #{user1.name} follow #{@user2.name}"
    end

    puts "Now you have #{Followship.count} fake followships data!"
  end


end
