class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @replies = Reply.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end
end
