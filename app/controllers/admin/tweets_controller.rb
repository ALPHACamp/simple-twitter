class Admin::TweetsController < Admin::BaseController
  
  #顯示所有的tweet
  def index
    @tweets = Tweet.all
    @user = current_user
  end

  #刪除該則tweet
  def destroy
    set_tweets
  end

  private

  def set_tweets
    @tweet = Tweet.find(params[:id])
  end
end
