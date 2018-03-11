namespace :dev do
  task fake_destroy_all: :environment do
    Followship.destroy_all
    Like.destroy_all
    Reply.destroy_all
    Tweet.destroy_all
    # 在還沒找到方法不刪 admin 之前，先不刪 user
  end

  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    # User.destroy_all
    20.times do |i|
      # file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: FFaker::Name::first_name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(3),
        avatar: "https://cdn.filestackcontent.com/wlQFRRvtS5Sj7iMmawrb"
      )

      user.save!
      puts user.name
    end
  end

  task fake_tweet: :environment do
    40.times do
      tweet = Tweet.new(
        user_id: User.all.sample.id,
        description: FFaker::Lorem::sentence(3)
      )

      tweet.save!
      puts "#{tweet.description}"
    end
  end

  task fake_like: :environment do
    Like.destroy_all
    20.times do
      like = Like.new(
        user_id: User.all.order(:id).first(20).sample.id,
        tweet_id: Tweet.all.order(id: :desc).first(10).sample.id
      )

      like.save
    end
    puts "20 like record created."
  end

  task fake_reply: :environment do
    Reply.destroy_all
    20.times do
      reply = Reply.new(
        user_id: User.all.order(:id).first(20).sample.id,
        tweet_id: Tweet.all.order(id: :desc).first(10).sample.id,
        comment: FFaker::Lorem::sentence(3)
      )

      reply.save!
    end
    puts "20 replies created!"
  end

  task fake_followship: :environment do
    Followship.destroy_all

    20.times do
      followship = Followship.new(
        user_id: User.all.order(:id).first(20).sample.id,
        following_id: User.all.order(:id).last(10).sample.id
      )

      followship.save
    end
    puts "20 followships created."
  end
end
