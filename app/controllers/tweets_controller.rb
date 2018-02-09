class TweetsController < ApplicationController

  #是否已登入
  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.all.order(followers_count: :desc).limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create

    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!

    redirect_to tweets_url
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
