class TweetsController < ApplicationController
  before_action :authenticate_user!


  def index
    #@tweets = Tweet.page(params[:page]).per(10)
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    @tweet = Tweet.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.save
    redirect_to root_path
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
