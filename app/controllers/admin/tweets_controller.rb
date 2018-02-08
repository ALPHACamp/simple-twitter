class Admin::TweetsController < Admin::BaseController
  
  #顯示所有的tweet
  def index
    @tweets = Tweet.all
  end

  #刪除該則tweet
  def destroy
    set_tweet
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
