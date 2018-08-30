class Admin::TweetsController < Admin::BaseController
  
  def index
    # 顯示全部 tweets 的資料
    @tweets = Tweet.all
  end

  def destroy
    @tweets = Tweet.find(params[:id])
    @tweets.destroy
    redirect_to admin_tweets_path
    falsh[:alert] = "tweet was delete"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
