RSpec.describe 'Admin::Tweet', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets) }
  let(:admin_user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets', role: 'admin')}

  context 'go to admin root page' do
    describe 'if normal user log in' do
      it 'should redirect to root path' do
        sign_in(user)
        get admin_root_path
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'if admin user log in' do
      it 'should see all tweets instance' do
        sign_in(admin_user)
        user_with_tweets
        get admin_root_path
        expect(response).to have_http_status 200
        expect(assigns(:tweets)).to eq Tweet.all
      end

      it 'can delete other users tweet' do
        sign_in(admin_user)
        user_with_tweets
        get admin_root_path
        expect(assigns(:tweets).count).to eq 5

        delete '/admin/tweets/1'
        expect(response).to redirect_to(admin_root_path)
        follow_redirect!

        expect(assigns(:tweets).count).to eq 4
        expect(response).to render_template(:index)
      end
    end
  end
end
