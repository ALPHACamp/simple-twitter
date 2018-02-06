class TweetsController < ApplicationController
  before_action :set_tweet, only:[:like, :unlike]
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
  end

  def like
    #set_tweet
    @tweet.likes.create!(user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    #set_tweet
    like = Like.where(tweet: @tweet, user: current_user).first
    like.destroy
    redirect_back(fallback_location: root_path)
  end

#################
  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
