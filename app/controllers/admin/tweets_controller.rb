class Admin::TweetsController < Admin::BaseController
  # 建立管理者認證
  before_action :authenticate_admin

  # 可看全部的推播
  def index
  	@tweets = Tweet.all
  end

  # 刪除推播
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "推播被刪除了"
    redirect_to admin_tweets_path
  end

end
