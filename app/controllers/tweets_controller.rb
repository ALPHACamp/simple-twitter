class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
    @users = User.all.order(created_at: :desc).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    flash[:notice] = "Tweet發送"
    redirect_to root_path

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
