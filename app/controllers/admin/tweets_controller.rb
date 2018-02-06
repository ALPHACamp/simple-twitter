class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(parmas[:id])
    @tweet.destroy
    redirect_to admin_tweets_path, alert: 'Tweet Deleted Successfully'
  end
end
