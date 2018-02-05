class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @users  # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  # def new
  #   @tweet = Tweet.new
  # end


  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :index
    end
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :description)
  end


end
