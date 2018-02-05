namespace :dev do

  task fake_tweet: :environment do

    Tweet.destroy_all
    50.times do |i|
      Tweet.create!(
        user: User.all.sample,
        description: FFaker::Lorem.phrase
        )

    end
    puts "建立假tweet完成"
    puts "共#{Tweet.count}個Tweet"
  end
end