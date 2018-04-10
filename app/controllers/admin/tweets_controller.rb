class Admin::TweetsController < Admin::BaseController
  # before_action :authenticate_user!  # 移到 application_controller
  # before_action :authenticate_admin  # 移到 base_controller

  def index
    @tweets = Tweet.all.includes(:replies, :user).order(replies_count: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "tweet was sucessfully deleted"
    redirect_to admin_root_path

  end
end
