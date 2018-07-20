class TweetsController < ApplicationController

  def index # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10) 
    @tweet = Tweet.new
  end

  def create
    @user = User.find(params:[:user_id])
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user 
    @tweet.save!
    redirect_to user_path(@user)
  end

  def like
  end

  def unlike
  end

end