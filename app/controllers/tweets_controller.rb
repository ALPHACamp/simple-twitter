class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
     @tweets = Tweet.all.order(created_at: :desc)
     @tweet = Tweet.new
     @users = User.order(followers_count: :desc).limit(10) 
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet created successfully"
      redirect_to tweets_path
    else
      flash.now[:alert] = "tweet failed to create"
      @tweets = Tweet.all.order(created_at: :desc)
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
