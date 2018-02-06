class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "Tweet destroyed"
    redirect_to action: :index
  end
end
