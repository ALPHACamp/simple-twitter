class Admin::TweetsController < Admin::BaseController
  
  #顯示所有的tweet
  def index
    @tweets = Tweet.all.includes(:replies, :user).order(replies_count: :desc)
  end

  #刪除該則tweet
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end

end
