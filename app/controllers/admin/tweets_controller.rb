class Admin::TweetsController < Admin::BaseController
    before_action :authenticate_user!
    before_action :authenticate_admin
  def index
    @tweets = Tweet.page(params[:page]).per(10)
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow"
      redirect_to root_path
    end
  end
end
