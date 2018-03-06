class TweetsController < ApplicationController

  def index
    # 基於測試規格，必須給定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users

    # Tweets：排序依日期，最新的在前
    @tweets = Tweet.all.order(created_at: :desc).limit(20)

    @tweet = Tweet.new

  end

  # 在首頁新增推文
  def create
    @tweet = Tweet.new(tweet_params)

    # 取得 FK: user_id 的值
    @tweet.user_id = current_user.id
    @tweet.save!

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
