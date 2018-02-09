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

     User.all.each do |user|
       rand(20).times do |i|
         user.tweets.create!(
           description: FFaker::Lorem.sentence,
           user: User.all.sample
         )


       end
     end
    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end


  task fake_reply: :environment do
    Reply.destroy_all

     Tweet.all.each do |tweet|
       rand(10).times do |i|
         tweet.replies.create!(
           comment: FFaker::Lorem.sentence,
           user: User.all.sample,
           tweet: Tweet.all.sample
         )


       end
     end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies data"
  end




  task fake_like: :environment do
    Like.destroy_all
     Tweet.all.each do |tweet|
       rand(10).times do |i|
         tweet.likes.create!(
           user: User.all.sample,
           tweet: Tweet.all.sample
         )
       end
     end
    puts "have created fake likes"
    puts "now you have #{Like.count} likes data"
  end



  task fake_follow: :environment do
       users = User.all
       users.each do |user|
         followings = User.all.sample(10)
         followings.each do |following|
           if(following != user)
             Followship.create!(
               user_id: user.id,
               following_id: following.id
             )
             puts "have created fake followships"
             puts "now you have #{following.count} followship data"
            #  puts "create followship #{user.name} and #{following.name}"
           end
         end
       end
    end


  #   task fake_followship: :environment do
  #   Followship.destroy_all
  #   puts "creating fake followship..."
  #   User.all.each do |u|
  #     @users = User.where.not(id: u.id).shuffle
  #     (rand(20)).times do
  #       u.followships.create!(
  #       following: @users.pop,
  #       )
  #     end
  #   end
  #   puts "now you have #{Followship.count} followship"
  # end

end
