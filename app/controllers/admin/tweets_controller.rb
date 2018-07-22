class Admin::TweetsController < Admin::BaseController

  #是否已登入
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.all
    @tweets = Tweet.all
  end

  def destroy
    @tweets = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end
end
