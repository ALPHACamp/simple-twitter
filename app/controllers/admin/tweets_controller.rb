class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  # 後台權限驗證
  before_action :authenticate_admin
  
  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"    
  end
end
