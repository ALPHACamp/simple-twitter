class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
    
  end

  def create

   
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
    # 新增方法若需使用,記得新增在before_action
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
