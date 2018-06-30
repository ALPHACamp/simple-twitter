namespace :dev do

  task fake_tweets: :environment do

    Tweet.destroy_all

    User.all.each do |user|

      user.tweets.create!(description: FFaker::Lorem.sentence)

    end

    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"



  end


end
