namespace :dev do
  task fake_user: :environment do
    User.destroy_all
    User.create(email: "test@test.com", password: "000000", name: "RT", role: "admin")
    puts "Default admin created!"

    url = "https://uinames.com/api/?ext&region=england"

      50.times do
        response = RestClient.get(url)
        data = JSON.parse(response.body)
      
    user = User.create!(
      email: data["email"],
      password:"000000",
      name: data["name"],
      introduction: FFaker::Lorem.paragraph,
      remote_avatar_url: data["photo"]
    )
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_tweet: :environment do
    Tweet.destroy_all

    User.all.each do |u|
      25.times do
        u.tweets.create!(
        description: FFaker::Tweet.tweet,
        )
      end
    end

    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |t|
      5.times do
        t.replies.create!(comment: FFaker::Lorem.phrase,
          user: User.all.sample)
      end
    end

      puts "have created fake replies"
      puts "now you have #{Reply.count} replies data"
  end

  task fake_followship: :environment do
    Followship.destroy_all

    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      20.times do
        u.followships.create!(
          following: @users.pop,
        )
      end
    end

    puts "have created fake followship"
    puts "now you have #{Followship.count} folloings data"
  end

  task fake_like: :environment do
    Like.destroy_all

    User.all.each do |u|
      20.times do
        u.likes.create!(
          tweet: Tweet.all.sample,
          )
      end
    end

    puts "have created fake like"
    puts "now you have #{Like.count} fake like data"
  end

end
