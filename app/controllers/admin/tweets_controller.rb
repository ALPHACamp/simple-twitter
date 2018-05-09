class Admin::TweetsController < Admin::BaseController
  # before_action :authenticate_user!
  # before_action :authenticate_admin

  def index
    @tweets = Tweet.all.includes(:replies, :user).order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to(admin_root_path)
    flash[:alert] = "Tweet was deleted"
  end

end
