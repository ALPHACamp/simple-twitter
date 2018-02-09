class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  
  def index
     # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
    
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_to tweets_path
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path
  end

  private
    # 新增方法若需使用,記得新增在before_action
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
