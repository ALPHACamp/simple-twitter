class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @tweets = Tweet.order(created_at: :desc)
    @users = User.all
  end

  def destroy
  end
end
