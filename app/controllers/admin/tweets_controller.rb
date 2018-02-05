class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    flash[:alert] = "tweets delete!"
    redirect_to admin_tweets_path
  end
end
