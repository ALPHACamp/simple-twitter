class Admin::TweetsController < Admin::BaseController
    before_action :authenticate_user!
    before_action :authenticate_admin
  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end
end
