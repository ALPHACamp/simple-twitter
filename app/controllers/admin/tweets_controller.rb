class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.includes(:replies, :user).order(replies_count: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    # redirect_to admin_root_path
  end
end
