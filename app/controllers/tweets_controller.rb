class TweetsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :set_tweet, only: [:index, ]

  
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    # @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    # @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
    
  end

  def create

    #redirect_to restaurant_path(@restaurant)
  end

  def like
  end

  def unlike
  end
end
