class Admin::TweetsController < Admin::BaseController
  def index
    # 看見所有推播
    @tweets = Tweet.all
    @users = User.order(followers_count: :desc).limit(10)
  end



  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end
end
