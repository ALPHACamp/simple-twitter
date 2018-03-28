class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    # @users基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_to root_path
  end

  def like
    Like.create!(tweet: @tweet, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back(fallback_location:root_path)
  end
private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
