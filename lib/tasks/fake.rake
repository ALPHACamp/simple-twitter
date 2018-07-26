namespace :dev do
  task fake_user: :environment do
    20.times do |i|
      User.create!(email: FFaker::Internet.free_email,
        password: FFaker::Education.school,
        name: FFaker::Name.unique.name
      )
    end

    puts "have create fake user"
    puts "now you have #{User.count} users data"
  end

  task fake_tweet: :environment do
    3.times do |i|
      User.all.each do |u|
        Tweet.create!(description: FFaker::Lorem.sentence,
          user_id: u.id
        )
      end
    end

    puts "have create fake tweets"
    puts "now you have #{Tweet.count} tweets"
  end

  task fake_reply: :environment do
    2.times do |i|
      Tweet.all.each do |t|
        Reply.create!(comment: FFaker::Lorem.sentence,
          user_id: User.all.sample.id,
          tweet_id: t.id
          )
      end
    end
  end

end