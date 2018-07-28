class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_admin
  before_action :set_tweet, only:  [:show, :destroy]
  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end

    private

  def set_tweet
    @tweet = Tweet.find(params[:id])  
  end

  def tweet_params
    params.require(:tweet).permit(:name, :description)
  end


end
