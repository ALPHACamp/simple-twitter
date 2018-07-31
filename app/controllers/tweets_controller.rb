class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]

  def index
   @users = User.order(followers_count: :desc).limit(10)
   # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
   @tweet = Tweet.new
   @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet successfully!!!"
      redirect_to tweets_path
    else
      flash[:alert] = "限字140"
      redirect_to tweets_path
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
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