class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroyad
    flash[:alert] = "tweets delete!"
    redirect_to admin_root_path
  end
end
