class Admin::TweetsController < Admin::BaseController
  def index
    @tweets_admin = Tweet.order(created_at: :desc)
    @tweets = @tweets_admin.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path, alert: 'Tweet Deleted Successfully'
  end
end
