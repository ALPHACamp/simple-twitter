class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Tweet was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = "Tweet failed"
      render "index"
    end 
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)  
  end
end
