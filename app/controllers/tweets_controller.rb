class TweetsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_admin

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet =  Tweet.new
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet =  current_user.tweets.build(tweet_params)
    @tweet.save!
    redirect_to tweets_path
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    @likes = Like.where(tweet: @tweet, user: current_user)
    @likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
