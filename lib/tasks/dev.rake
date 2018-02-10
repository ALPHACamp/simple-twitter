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
      puts "now you have #{User.count} users data"
  end


  task fake_followship: :environment do
    Followship.destroy_all

    until Followship.count == 20 do
    
      @sample_user=User.all.sample.id
      @sample_following=User.all.sample.id

      until @sample_user != @sample_following do
        @sample_following=User.all.sample.id
      end

      Followship.create!(
        following_id: @sample_following,
        user_id: @sample_user
        )
    end

      puts "have created fake followship"
      puts "now you have #{Followship.count} followship data"   
    end
  task fake_tweet: :environment do
    Tweet.destroy_all

      20.times do
        @ntw=Tweet.new(
          description: '4444',
          user: User.all.sample
          )
        @ntw.save!
      end
      puts "have created fake tweet"
      puts "now you have #{Tweet.count} tweet data"   
  end
  task fake_reply: :environment do
    Reply.destroy_all

    for i in 0...Tweet.all.count do
      3.times do
        Reply.create!(
          comment: FFaker::Lorem.paragraph(sentence_count = 1),
          tweet: Tweet.all.sample,
          user: User.all.sample
          )
      end
    end
      puts "have created fake reply"
      puts "now you have #{Reply.count} reply data"   
  end
  task fake_like: :environment do
    Like.destroy_all

      30.times do
        Like.create!(
          tweet: Tweet.all.sample,
          user: User.all.sample
          )
      end
      puts "have created fake like"
      puts "now you have #{Like.count} like data"   
  end

end
