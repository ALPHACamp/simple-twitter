module TweetsHelper

  def create_user_list
    user1 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user1')
    user2 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user2')
    user3 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user3')
    user4 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user4')
    user5 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user5')
    user6 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user6')
    user7 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user7')
    user8 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user8')
    user9 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user9')
    user10 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user10')
    user11 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user11')
    user12 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user12')
    user13 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user13')
    user14 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user14')
    user15 = FactoryBot.create(:user, email: FFaker::Internet.email, name: 'user15')
  end

  def create_followship_table
    User.first(15).each do |i|
      for j in i.id + 1..15
        Followship.create(user_id: i.id, following_id: j)
      end
    end
  end

  def create_tweets
    User.first.tweets.create(
      [{ description: 'first tweet', created_at: 5.days.ago },
      { description: 'second tweet', created_at: 4.days.ago },
      { description: 'third tweet', created_at: 3.days.ago },
      { description: 'forth tweet', created_at: 2.days.ago },
      { description: 'fifth tweet', created_at: 1.days.ago }]
    )
  end
end
