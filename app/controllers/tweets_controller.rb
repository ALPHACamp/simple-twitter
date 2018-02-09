class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.popular_ten
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(7)
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @reply = Reply.new
    @replies = Reply.where(tweet_id: @tweet.id)
  end

  def create
    Tweet.transaction do
      @tweet = Tweet.new(tweet_params)
      @tweet.user = current_user
      user = @tweet.user.increment(:tweets_count, 1)
      user.save
      @tweet.save
    end
    redirect_to tweets_path
  end

  def like
    Tweet.transaction do
      tweet = Tweet.find(params[:id])
      Like.create!(user: current_user, tweet: tweet)
      user = current_user.increment(:likes_count, 1)
      user.save
    end
    redirect_to tweets_path
  end

  def unlike
    Tweet.transaction do
      tweet = Tweet.find(params[:id])
      likes = Like.where(tweet: tweet, user: current_user).first
      likes.destroy
      user = current_user.decrement(:likes_count, 1)
      user.save
    end
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
