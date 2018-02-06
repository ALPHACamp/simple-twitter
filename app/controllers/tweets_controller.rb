class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:tweets)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(7)
    @tweet = Tweet.new
    @popular_tweeter = @users.popular_ten
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
    @replies = Reply.where(tweet_id: @tweet.id)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.save
    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    user = @tweet.user.increment(:likes_count, 1)
    user.save
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user).first
    likes.destroy
    user = @tweet.user.decrement(:likes_count, 1)
    user.save
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
