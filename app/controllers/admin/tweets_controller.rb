class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.includes(:replies, :user).order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice]="Tweet has been destroyed"
    redirect_to admin_tweets_path
  end

end
