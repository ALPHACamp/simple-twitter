class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet was successfully created!"
      redirect_to root_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to root_path(tweet_params)
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
