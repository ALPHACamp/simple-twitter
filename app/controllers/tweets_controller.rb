class TweetsController < ApplicationController
# 登入認證
before_action :authenticate_user!
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all
    @tweet = Tweet.new #在index建立tweet容器來建立短文
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweeted successfully"
      redirect_to tweets_path
    else
      flash.now[:alert] = "Tweeted faield"
      render :index
    end
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
