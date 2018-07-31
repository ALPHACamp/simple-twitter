class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only: [:destroy]
  


  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path(@tweet)
    flash[:alert] = "tweet was delete"
  end

private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:name, :avatar, :introduction)
  end

end
