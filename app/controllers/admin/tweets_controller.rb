class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet has destroyed"

  end
  private
  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end
end
