class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.all



  end

  def create
  end

  def like
      @tweet = Tweet.find(params[:id])
      @tweet.likes.create!(user: current_user)
      @tweet.likes_count = @tweet.likes_count+1
      redirect_back(fallback_location: root_path)
  end

  def unlike
      @tweet = Tweet.find(params[:id])
      likes= Like.where(tweet: @tweet, user: current_user)
      @tweet.likes_count = @tweet.likes_count-1
      likes.destroy_all
      redirect_back(fallback_location: root_path)
  end



  private

  def tweet_params
    params.require(:tweet).permit()
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
