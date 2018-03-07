class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]

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

    if @tweet.save
      redirect_to tweets_path
    else
      redirect_to tweets_path
    end
  end

  # 建立推文喜好記錄 tweets#like
  def like
    # set_tweet

    @like = Like.create!(user_id: current_user.id, tweet_id: @tweet.id)

    redirect_to tweets_path
  end

  # 刪除推文喜好記錄 tweets#unlike
  def unlike
    # set_tweet

    like = Like.where(user_id: current_user.id, tweet_id: @tweet.id)

    like.destroy_all
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
