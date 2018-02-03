class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @tweets = Tweet.all
    @users = User.all
  end

  def destroy
  end
end
