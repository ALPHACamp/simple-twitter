class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only: [:destroy]

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end

