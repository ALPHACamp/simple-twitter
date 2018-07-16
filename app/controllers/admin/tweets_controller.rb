class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only:  [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.all
  end

  def destroy
    if current_user.admin?
      @tweet.destroy
      redirect_to admin_tweets_path
      flash[:alert] = "tweet was deleted"
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
