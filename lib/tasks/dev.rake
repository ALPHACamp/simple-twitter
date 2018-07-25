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
      3.times do |i|
        user.tweets.create!(
          description: FFaker::Lorem::phrase(10)
        )
    end

    puts "reated fake tweets"
    puts "now you have #{Tweet.count} users data"
  end
end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |r|
      3.times do |i|
        r.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created fake replies"
    puts "now you have #{Reply.count} replies' data"
  end


end
