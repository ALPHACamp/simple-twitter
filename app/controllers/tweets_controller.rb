class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  
  def index
    @tweets = Tweet.includes(:likes, :user, :liked_users).order(created_at: :desc)
    @tweet = Tweet.new
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet successfully created"
      redirect_to tweets_path
    else
      flash[:alert] = "Something went wrong"
      @tweets = Tweet.includes(:likes, :user, :liked_users).order(created_at: :desc)
      @users = User.order(followers_count: :desc).limit(10)
      @tweet = Tweet.new
      render 'index'
    end
  end
  
  #讓tweets可以被喜歡
  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  #讓tweets可以取消喜歡
  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
