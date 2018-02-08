class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.order(created_at: :desc);
  end

  def destroy
    @tweet = Tweet.find(params[:id]);
    @tweet.destroy;
    @tweet.user.tweets_count -= 1
    @tweet.user.save
    redirect_to admin_tweets_path
  end
end
