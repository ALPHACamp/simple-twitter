class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)

  end

  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.save

    redirect_to tweets_path
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
    
  end

end
