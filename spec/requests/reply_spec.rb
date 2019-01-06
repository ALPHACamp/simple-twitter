RSpec.describe 'Reply', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets) }
  let(:tweet) { create(:tweet, user: user) }
  let(:reply) { create(:reply, user: user, tweet: tweet) }

  describe '/tweets/:id/replies #index' do
    before do
      tweet
      reply
      sign_in(user)
      get tweet_replies_path(tweet)
    end

    it 'can see all replies instance' do
      expect(assigns(:replies)).to eq(tweet.replies)
    end

    it 'should render index' do
      expect(response).to render_template(:index)
    end

    it 'have reply instance' do
      expect(assigns(:reply)).not_to be nil
    end
  end

  context '#post' do
    before do
      tweet
      sign_in(user)
      post '/tweets/1/replies', params: { reply: { comment: 'I am another comment' } }
    end

    describe 'when successfully save' do
      it 'will create reply on that tweet' do
        expect(tweet.replies.count).to eq 1
      end

      it 'will redirect to index' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(assigns(:replies))
      end

      it 'will create current users reply' do
        expect(Reply.last.user).to eq user
      end
    end

    describe 'when failed' do
      it 'will redirect index' do
        expect(response).to redirect_to(assigns(:replies))
      end
    end
  end
end
