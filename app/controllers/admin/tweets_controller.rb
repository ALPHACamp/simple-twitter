class Admin::TweetsController < Admin::BaseController


  def index




    @ordered_tweets = Tweet.order(created_at: :desc)
    @tweets = @ordered_tweets.all


  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end
end
