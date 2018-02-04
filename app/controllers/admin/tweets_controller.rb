class Admin::TweetsController < Admin::BaseController
before_action :set_tweet, only: [:show, :destroy]
  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @replies = @tweet.replies.all
  end

  def destroy
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
