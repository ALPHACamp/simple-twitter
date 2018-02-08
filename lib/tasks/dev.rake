namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      # 這組路徑在 Heroku 上無法使用，同學可跳過 Heroku 上圖片顯示的問題
      # 若特別想攻克的同學可參考 Filestack 說明 => https://lighthouse.alphacamp.co/units/1110
      
      user = User.new(
        # name: name,
        name: "user#{i}",
        email: "user#{i}@mail.co",
        password: "000000",
        # email: "#{name}@mail.co",
        # password: "123456",
        introduction: FFaker::Lorem::sentence(30),
      )

      user.save!
      puts user.name
    end
  end

  task set_fake_avatars: :environment do
    User.find(1).update(avatar: "https://cdn.filestackcontent.com/kX5PwVUSNO13jBIrHACa")
    User.find(2).update(avatar: "https://cdn.filestackcontent.com/lEeke6p9RvO0Vbn7LgaW")
    User.find(3).update(avatar: "https://cdn.filestackcontent.com/N6WpsVjLQCO7BZSmvm8F")
    User.find(4).update(avatar: "https://cdn.filestackcontent.com/cZnMhFbjSXUzsKgrDpMC")
    User.find(5).update(avatar: "https://cdn.filestackcontent.com/35GfCpbQSCBaBTisAmpA")
    User.find(6).update(avatar: "https://cdn.filestackcontent.com/Hx4hxyNJT1Go2hD7m5Z8")
    User.find(7).update(avatar: "https://cdn.filestackcontent.com/V5pDhT1LQVWWKtRM4d9d")
    User.find(8).update(avatar: "https://cdn.filestackcontent.com/ViWvDUHLQiG4cNrssHLJ")
    User.find(9).update(avatar: "https://cdn.filestackcontent.com/kxETitWgTyely2tPvp69")
    User.find(10).update(avatar: "https://cdn.filestackcontent.com/oTYqX1UnRlOkxJi4f0kj")
    User.find(11).update(avatar: "https://cdn.filestackcontent.com/SOrRDSgTIeq2ccTTqZii")
    User.find(12).update(avatar: "https://cdn.filestackcontent.com/7IPDLasKRvKmPG10TYla")
    User.find(13).update(avatar: "https://cdn.filestackcontent.com/NuvXD4XNRiCqt1WWfgfc")
    User.find(14).update(avatar: "https://cdn.filestackcontent.com/41X5f0E8QtyjehQBBWC3")
    User.find(15).update(avatar: "https://cdn.filestackcontent.com/SpHlTqmSJO4KoZ9Gygr3")
    User.find(16).update(avatar: "https://cdn.filestackcontent.com/XSBXVWssQnuL4CDOPe0W")
    User.find(17).update(avatar: "https://cdn.filestackcontent.com/PrwL01xQqaHF21f9Xou2")
    User.find(18).update(avatar: "https://cdn.filestackcontent.com/hqJpE9GrRx22rtymCURZ")
    User.find(19).update(avatar: "https://cdn.filestackcontent.com/CItkLWQuGj9XwXKL0elA")
    User.find(20).update(avatar: "https://cdn.filestackcontent.com/vzh7aMvR2qPWuxSMlV2p")
  end

  task upload_fake_avatars: :environment do
    file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
    client = FilestackClient.new('AusaD7GlvTDSm2n1fTcwTz')
    filelink = client.upload(filepath: file)
  end

  task fake_tweets: :environment do
    Tweet.destroy_all
    @users = User.all
    @users.each do |user|
      (rand(20)+1).times do |variable|
        user.tweets.create!(description: FFaker::Tweet.body)
      end
      # puts "#{user.name} has #{user.tweets.count} tweets!"
    end
    puts "Now you have #{Tweet.count} tweets!"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    @tweets = Tweet.all
    @tweets.each do |tweet|
      3.times do |variable|
        tweet.replies.create!(comment: FFaker::Tweet.body,
          user: User.all.sample)
      end
    end
    puts "Now you have #{Reply.count} replies!"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    puts "creating fake followship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      (rand(20)).times do
        u.followships.create!(
        following: @users.pop,
        )      
      end 
    end
    puts "now you have #{Followship.count} followship"
  end

  #fake like
  task fake_like: :environment do
    Like.destroy_all
    puts "creating fake likes..." 
    User.all.each do |u|
     5.times do
       u.likes.create!(
        tweet: Tweet.all.sample,
       )      
     end
    end
    puts "now you have #{Like.count} liked tweets"
  end

  # count likes of user's tweet.
  # this needs manual execute after fake_all, or it won't work
  task count_got_likes: :environment do
    User.all.each do |u|
      u.update(got_likes_count: u.tweets.joins(:likes).count) 
      puts "#{u.name} got #{u.got_likes_count} likes"
    end
  end

  task test: :environment do
    User.all.each do |u|
      puts "#{u.name} ======= #{u.got_likes_count}"      
    end
  end

  #fake all data
  task fake_all: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:set_fake_avatars'].execute
    Rake::Task['dev:fake_tweets'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_followship'].execute
    Rake::Task['dev:fake_like'].execute
    # Rake::Task['db:seed'].execute
  end
end
