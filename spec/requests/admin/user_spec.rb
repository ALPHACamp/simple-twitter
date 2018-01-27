RSpec.describe 'Admin::User', type: :request do
  let(:user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets') }
  let(:user_with_tweets) { create(:user_with_tweets) }
  let(:admin_user) { create(:user, email: FFaker::Internet.email, name: 'no_tweets', role: 'admin')}

  context 'go to admin user page' do
    describe 'if normal user log in' do
      it 'should redirect to root path' do
        sign_in(user)
        get admin_users_path
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'if admin user log in' do
      it 'should see all tweets instance' do
        sign_in(admin_user)
        user_with_tweets
        get admin_users_path
        expect(response).to have_http_status 200
        expect(assigns(:users)).to eq User.all
      end
    end
  end
end
