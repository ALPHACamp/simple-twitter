class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweett was deleted"
  end

end
