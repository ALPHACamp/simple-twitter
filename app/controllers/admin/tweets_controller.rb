class Admin::TweetsController < Admin::BaseController
  def index
    @users = User.all
    @tweets = Tweet.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:notice] = "Tweet was deleted! "
  end
end
