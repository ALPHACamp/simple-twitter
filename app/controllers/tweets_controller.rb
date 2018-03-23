class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.save!
    redirect_back(fallback_location: root_path)
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
