class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    user = @tweet.user.decrement(:tweets_count, 1)
    user.save
    @tweet.destroy
    redirect_to admin_tweets_path
  end
end
