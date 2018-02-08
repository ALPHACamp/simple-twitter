class TweetsController < ApplicationController
  before_action :authenticate_user!

  # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all
  end

  def create
    @user = current_user.id
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    flash[:notice] = "tweet was successfully created"

    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.increment!(:likes_count)
    @like = Like.create!(user: current_user, tweet: @tweet)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    @tweet.decrement!(:likes_count)
    @likes = Like.where(user: current_user, tweet: @tweet)
    @likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
