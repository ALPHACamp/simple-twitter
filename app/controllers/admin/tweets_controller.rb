class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "Tweet was deleted!"
    redirect_to admin_root_path
  end
end