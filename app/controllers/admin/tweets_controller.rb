class Admin::TweetsController < Admin::BaseController

  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "推文已刪除"
  end

end
