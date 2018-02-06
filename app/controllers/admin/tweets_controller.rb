class Admin::TweetsController < Admin::BaseController

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Tweet was successfully deleted!"
    redirect_back(fallback_location: root_path)
  end
end
