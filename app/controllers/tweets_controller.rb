class TweetsController < ApplicationController

  def index
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc).all
  end

  def create
    @tweet = current_user.tweets.create(tweet_params)
  end

  def like
    @like = current_user.likes.create(tweet_id: params[:id])
    @tweet = Tweet.find(params[:id])
  end

  def unlike
    @like = current_user.likes.find_by(tweet_id: params[:id])
    @tweet = Tweet.find(params[:id])
    @like.destroy
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
