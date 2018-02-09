class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(9)
    
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_back(fallback_location: admin_root_path)
    flash[:alert] = "The tweet was deleted."
  end
end
