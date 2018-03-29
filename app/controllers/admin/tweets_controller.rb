class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only: [:destroy]
  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "It's already deleted"
  end
private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
