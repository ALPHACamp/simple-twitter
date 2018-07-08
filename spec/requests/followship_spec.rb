RSpec.describe 'Followship', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets) }

  context '#create' do
    describe 'when user1 wants to follow user2' do
      before do
        user
        user_with_tweets
        sign_in(user)
        post '/followships', params: { following_id: user_with_tweets.id }
      end

      it 'will show following' do
        expect(Followship.count).to eq 1
        expect(Followship.last.following_id).to eq user_with_tweets.id
      end
    end
  end

  context '#destroy' do
    describe 'when user1 wants to unfollow user2' do
      before do
        user
        user_with_tweets
        sign_in(user)
        Followship.create(user_id: user.id, following_id: user_with_tweets.id)
      end

      it 'will show following' do
        expect(Followship.count).to eq 1
        delete '/followships/2'
        expect(Followship.count).to eq 0
      end
    end
  end
end
