class Admin::TweetsController < Admin::BaseController
  after_action :update_count , only: :destroy


  def index
    @tweets = Tweet.all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:alert] = "Tweet destroyed"
    redirect_to action: :index
  end

  def update_count
    @tweet.user.update_count
  end
end
