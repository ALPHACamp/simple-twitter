class TweetsController < ApplicationController

  def index
    @users = User.order(followers_count: :desc).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "留言成功！"
      redirect_to tweets_path(@user)
    else
      flash[:alert] = "留言不可以空白!!"
      redirect_to tweets_path(@restaurant)
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
