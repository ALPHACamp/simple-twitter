class TweetsController < ApplicationController

  def index
    @tweets = Tweet.page(params[:page]).per(20)
    @tweet = Tweet.new
    # @users 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      @tweets = Tweet.page(params[:page]).per(20)
      render :index
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
