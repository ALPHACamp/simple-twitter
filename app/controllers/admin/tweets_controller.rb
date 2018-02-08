class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Tweet was deleted"
    redirect_to admin_tweets_path
  end
end
