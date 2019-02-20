RSpec.describe 'Tweet', type: :request do
  include TweetsHelper

  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets, name: 'user_with_tweets') }

  context '#index' do
    describe 'user not login' do
      it 'will redirect to log in page' do
        get tweets_path
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
      end
    end

    context 'user log in' do
      before do
        create_user_list
        create_followship_table
        create_tweets
        user
        user_with_tweets
        sign_in(user)
        get tweets_path
      end

      it 'can render index' do
        expect(response).to render_template(:index)
      end

      describe 'user behaviour' do
        it 'show current_user as log in user' do
          expect(controller.current_user).to eq(user)
        end

        it 'can show all popular user' do
          expect(assigns(:users).first.name).to eq 'user15'
          expect(assigns(:users).last.name).to eq 'user6'
        end
      end

      describe 'tweets behaviour' do
        it 'will show 200' do
          expect(response).to have_http_status(200)
        end

        it 'can see all tweets instance' do
          expect(assigns(:tweets).count).to eq 6
          expect(assigns(:tweets).first.user).to eq(user_with_tweets)
          expect(assigns(:tweets).second.description).to eq('fifth tweet')
        end

        it 'have tweet instance' do
          expect(assigns(:tweet)).not_to be nil
        end
      end
    end
  end

  context '#post' do
    before do
      user
      sign_in(user)
      post '/tweets', params: { tweet: { description: 'I am another tweet' } }
    end

    describe 'when successfully save' do
      it 'will redirect to index' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(assigns(:tweets))
      end

      it 'will create current users tweet' do
        expect(Tweet.last.user).to eq user
      end
    end

    describe 'when failed' do
      it 'will redirect index' do
        expect(response).to redirect_to(assigns(:tweets))
      end
    end
  end

  context '#like' do
    before do
      user
      user_with_tweets
      sign_in(user)
      post '/tweets/1/like'
    end

    describe 'like first tweet' do
      it 'will save like' do
        expect(user.likes.count).to eq 1
        expect(user.likes.first.tweet_id).to eq 1
      end

      it 'will redirect index' do
        expect(response).to redirect_to tweets_path
      end
    end
  end

  context '#unlike' do
    before do
      user
      user_with_tweets
      sign_in(user)
      Like.create(user_id: 1, tweet_id: 1)
      post '/tweets/1/unlike'
    end

    it 'will delete like' do
      expect(user.likes.count).to eq 0
    end

    it 'will redirect index' do
      expect(response).to redirect_to tweets_path
    end
  end
end
