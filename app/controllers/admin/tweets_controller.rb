class Admin::TweetsController < Admin::BaseController
  before_action :set_restaurant, only:  [:show, :destroy]
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end

end
