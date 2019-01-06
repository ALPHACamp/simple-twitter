RSpec.describe 'Followship', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets, name: 'user_with_tweets') }

  context '#create' do
    describe 'when user1 wants to follow user2' do
      before do
        user
        user_with_tweets
        sign_in(user)

      end

      it 'will show following' do
        post '/followships', params: { following_id: user_with_tweets.id }
        expect(Followship.count).to eq 1
        expect(Followship.last.following_id).to eq user_with_tweets.id
      end

      it 'can not follow self' do
        post '/followships', params: { following_id: user.id }
        expect(Followship.count).to eq 0
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
        delete "/followships/#{Followship.first.following_id}"
        expect(Followship.count).to eq 0
      end
    end
  end
end
