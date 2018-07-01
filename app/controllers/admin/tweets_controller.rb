class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(20)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "You've deleted a tweet!"
    redirect_to admin_root_path
  end
end
