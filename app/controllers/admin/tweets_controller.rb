class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy 

    if @tweet.errors.any?
      flash[:alert] = @tweet.errors.full_messages.to_sentense
    else
      flash[:notice] = "Tweet was successfully deleted!!!"
    end
    
    redirect_to admin_root_path      
  end
end
