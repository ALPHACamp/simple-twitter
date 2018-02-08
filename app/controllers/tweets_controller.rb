class TweetsController < ApplicationController

  #是否已登入
  before_action :authenticate_user!

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create

    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!

    redirect_to tweets_url
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
