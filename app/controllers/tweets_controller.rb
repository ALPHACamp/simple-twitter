class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.includes(:likes, :user, :like_users).order(created_at: :desc).page(params[:page]).per(15)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.js
        format.html { redirect_to tweets_path }
      else
        flash[:alert] = @tweet.errors.full_messages.to_sentence
        format.html { redirect_to tweets_path }
      end
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.html { redirect_to tweets_path }
      format.js
    end
  end

  def unlike
    @like = Like.where(user: current_user, tweet: @tweet).first
    @like.destroy
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.html { redirect_to tweets_path }
      format.js
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
