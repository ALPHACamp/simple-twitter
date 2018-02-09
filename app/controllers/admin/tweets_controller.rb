class Admin::TweetsController < Admin::BaseController
  def index
    @user = current_user
    @tweets = Tweet.all
    @replies = Reply.all
  end

  def destroy
    @tweet=Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
  end
end
