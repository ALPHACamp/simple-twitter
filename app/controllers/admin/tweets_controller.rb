class Admin::TweetsController < Admin::BaseController

  def index
    @tweets = Tweet.all
    @tweets = Tweet.includes(:user, :replies, replies: :user).order("created_at desc")
  end

  def destroy

    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "Tweet was deleted"
  end


end
