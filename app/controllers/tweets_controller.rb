class TweetsController < ApplicationController

  def index
    @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = current_user.tweets.new()
  end

  def create
  end

  def like
  end

  def unlike
  end

end
