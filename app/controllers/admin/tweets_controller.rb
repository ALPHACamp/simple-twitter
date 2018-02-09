class Admin::TweetsController < Admin::BaseController
  def index
     #@tweets = Tweet.page(params[:page]).per(10)
    @tweets = Tweet.all
  end
  
  before_action :set_tweet, only:  [:show, :edit, :update, :destroy]

  def destroy
     @tweet.destroy
     redirect_to admin_tweets_path
     flash[:alert] = "tweet was deleted"
  end
  
  
  
  private
  
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
