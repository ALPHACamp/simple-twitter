class Admin::TweetsController < Admin::BaseController



  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "Tweet was deleted"
  end
end
