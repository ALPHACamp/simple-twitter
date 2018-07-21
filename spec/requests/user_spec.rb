RSpec.describe 'User', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets, name: 'user_with_tweets') }
  let(:tweet) { create(:tweet, user: user) }
  let(:tweet2) { create(:tweet, user: user_with_tweets) }
  let(:tweet3) { create(:tweet, user: user) }
  let(:tweet4) { create(:tweet, user: user_with_tweets) }
  let(:tweet5) { create(:tweet, user: user) }
  let(:reply) { create(:reply, user: user, tweet: tweet) }

  context '#tweets' do
    before do
      user_with_tweets
      sign_in(user_with_tweets)
    end

    describe 'go to current_user page' do
      it 'will show current users tweets' do
        get tweets_user_path(user_with_tweets)
        expect(assigns(:tweets)).to eq controller.current_user.tweets
      end
    end

    describe 'go to other user page' do
      it 'will show other users tweets' do
        get tweets_user_path(user)
        expect(assigns(:tweets).count).to eq 0

        user.tweets.create(description: 'add tweets!')

        get tweets_user_path(user)
        expect(assigns(:tweets).count).to eq 1
      end
    end
  end

  context '#edit' do
    before do
      user_with_tweets
      sign_in(user_with_tweets)
    end

    describe 'go to edit page' do
      it 'will render edit page' do
        get edit_user_path(user_with_tweets)
        expect(response).to render_template(:edit)
      end

      it 'will redirect if not this user' do
        get edit_user_path(user)
        expect(response).to redirect_to(tweets_user_path(user))
      end
    end
  end

  context '#update' do
    before do
      user_with_tweets
      sign_in(user_with_tweets)
    end

    describe 'successfully update' do
      it 'will change users intro' do
        expect(user_with_tweets.introduction).to be nil
        patch "/users/#{user_with_tweets.id}", params: {
          user: {
            introduction: 'introduction'
          }
        }
        user_with_tweets.reload
        expect(user_with_tweets.introduction).to_not be_nil
        expect(user_with_tweets.introduction.length).not_to be_zero
      end
    end
  end

  context '#followings #followers' do
    let(:user2) { create(:user, email: FFaker::Internet.email, name: 'user2') }
    let(:user3) { create(:user, email: FFaker::Internet.email, name: 'user3') }
    let(:user4) { create(:user, email: FFaker::Internet.email, name: 'user4') }

    before do
      user_with_tweets
      Followship.create(user_id: user_with_tweets.id, following_id: user.id, updated_at: 1.days.ago, created_at: 1.days.ago)
      Followship.create(user_id: user_with_tweets.id, following_id: user2.id, updated_at: 2.days.ago, created_at: 2.days.ago)
      Followship.create(user_id: user_with_tweets.id, following_id: user3.id, updated_at: 3.days.ago, created_at: 3.days.ago)
      Followship.create(user_id: user_with_tweets.id, following_id: user4.id, updated_at: 4.days.ago, created_at: 4.days.ago)
      Followship.create(user_id: user2.id, following_id: user.id, updated_at: 10.days.ago, created_at: 10.days.ago)
      sign_in(user_with_tweets)
    end

    describe 'go to following page' do
      it 'will show all following users' do
        get followings_user_path(user_with_tweets)
        expect(assigns(:followings).count).to eq 4
        expect(assigns(:followings).first.id).to eq user.id
      end
    end

    describe 'go to follower page' do
      it 'can see follower on other user page' do
        get followers_user_path(user)
        expect(assigns(:followers).count).to eq 2
        expect(assigns(:followers).first.id).to eq user_with_tweets.id
      end
    end
  end

  context '#likes' do
    before do
      user
      user_with_tweets
      Like.create(user_id: user.id, tweet_id: tweet.id, updated_at: 1.days.ago, created_at: 1.days.ago)
      Like.create(user_id: user.id, tweet_id: tweet2.id, updated_at: 2.days.ago, created_at: 2.days.ago)
      Like.create(user_id: user.id, tweet_id: tweet3.id, updated_at: 3.days.ago, created_at: 3.days.ago)
      Like.create(user_id: user.id, tweet_id: tweet4.id, updated_at: 4.days.ago, created_at: 4.days.ago)
      Like.create(user_id: user.id, tweet_id: tweet5.id, updated_at: 5.days.ago, created_at: 5.days.ago)
      sign_in(user)
    end

    describe 'go to likes page' do
      it 'show users like tweets' do
        get likes_user_path(user)
        expect(assigns(:likes).count).to eq 5
        expect(assigns(:likes).first.id).to eq tweet.id
      end
    end
  end
end
