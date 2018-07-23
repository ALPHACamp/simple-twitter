class Admin::TweetsController < Admin::BaseController
  


  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path(@tweet)
    flash[:alert] = "tweet was delete"
  end

    private

  def restaurant_params
    params.require(:tweet).permit(:name, :avatar, :introduction)
  end

end
