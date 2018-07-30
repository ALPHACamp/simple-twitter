namespace :dev do
  task fake_user: :environment do
    User.destroy_all
    User.create(email: "test@test.com", password: "000000", name: "RT", role: "admin")
    puts "Default admin created!"

    url = "https://uinames.com/api/?ext&region=england"

      20.times do
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
        description: FFaker::Lorem.paragraph
        )
      end
    end

    puts "have created fake tweets"
    puts "now you have #{Tweet.count} tweets data"
  end

end
