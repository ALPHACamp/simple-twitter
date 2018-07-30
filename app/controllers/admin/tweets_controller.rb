class Admin::TweetsController < Admin::BaseController
  def index
  	@tweets = Tweet.order(created_at: :desc)
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user.admin?
      @tweet.destroy
      redirect_to tweets_path
    end
    flash[:alert] = "tweet was deleted"
  end

  
  
end
