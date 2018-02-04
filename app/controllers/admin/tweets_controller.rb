class Admin::TweetsController < Admin::BaseController

  def index
    @tweets = Tweet.where(id: Tweet.pluck(:id).sample(10))
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Tweet was successfully deleted!"
    redirect_to admin_root_path
  end
end
