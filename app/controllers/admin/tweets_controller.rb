class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin 
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
    @users = User.all.order(follower_count: :desc).limit(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name, :description)
  end
end
