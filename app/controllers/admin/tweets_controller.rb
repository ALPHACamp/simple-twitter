class Admin::TweetsController < Admin::BaseController
  def index
    @tweets=Tweet.all.order("updated_at DESC")
  end

  def destroy
    @tweet=Tweet.find(params[:id])
    @tweet.destroy
    redirect_back(fallback_location: root_path)
  end
end
