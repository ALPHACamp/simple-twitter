namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫

  task fake: :environment do
  # task fake_user: :environment do
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        id: i+3,
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(20),
        avatar: file
      )

      user.save!
      puts user.name
    end
  # end

  # task fake_tweet: :environment do
    Tweet.destroy_all
    User.all.each do |user|
      (rand(20)+1).times do |i|
        user.tweets.create!(
          description: FFaker::Lorem::sentence(10)
          )
        puts "#{user.name} says '#{Tweet.count}' "
      end
    end
    puts "Have created fake tweet"
  # end

  # task fake_reply: :environment do
    Reply.destroy_all
    Tweet.all.each do |tweet|
      (rand(10)+1).times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies data"
  # end

  # task fake_like: :environment do
    Like.destroy_all
    User.all.each do |user|
      rand(50).times do |i|
        user.likes.create!(
          user_id: user.id, 
          tweet_id: Tweet.all.sample.id)
      end
    end
    Tweet.all.each do |tweet|
      tweet.likes_count = Like.where(tweet_id: tweet.id).count
      tweet.save
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} likes data"
  # end

  # task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
        user.followships.create!(
          user_id: user.id, 
          following_id: rand_user[i].id)
      end
    end
   
    puts "have created fake followship"
    puts "now you have #{Followship.count} followships data"
  end

  # # task fake_friendship: :environment do
  #   Friendship.destroy_all
  #   User.all.each do |user|
  #     rand_user = User.select{|x| x!=user}.sample(5)
  #     rand(5).times do |i|
  #       user.friendships.create!(
  #         user_id: user.id, 
  #         friend_id: rand_user[i].id)
  #     end
  #   end
   
  #   puts "have created fake friendship"
  #   puts "now you have #{Friendship.count} friendships data"
  # end

end
