class TweetsController < ApplicationController
  before_action :set_tweet, only:[:like, :unlike]
  def index

    @tweet = Tweet.new 
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @users = User.order(followers_count: :desc).limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料

  end

  def create
    @user =current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.save
    redirect_back(fallback_location: root_path)
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user).first
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
