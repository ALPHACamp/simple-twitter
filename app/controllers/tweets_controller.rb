class TweetsController < ApplicationController
  
  

  def index
    @users = Tweet.page(params[:page]).per(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.find(params[:user_id])
    @tweet = @tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_to tweet_path(@tweet)
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

end
