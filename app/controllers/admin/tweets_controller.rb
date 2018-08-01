class Admin::TweetsController < Admin::BaseController
  def index
    if current_user.admin? == false
      redirect_to root_path
    end
  	@tweets = Tweet.order(created_at: :desc)
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user.admin?
      @tweet.destroy
      redirect_to admin_root_path
    end
    flash[:alert] = "tweet was deleted"
  end

  
  
end
