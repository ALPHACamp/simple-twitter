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

end