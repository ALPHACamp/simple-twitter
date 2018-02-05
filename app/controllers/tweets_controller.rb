class TweetsController < ApplicationController
  before_action :authenticate_user!

  # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  def index
    @users = User.order(followers_count: :desc).limit(10) # 改過路由後，就變 nil:NilClass，git reset 也沒救 
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  def create
    @user = current_user.id
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    flash[:notice] = "tweet was successfully created"

    redirect_to tweets_path
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
