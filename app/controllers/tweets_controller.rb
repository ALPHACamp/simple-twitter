class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(:name).limit(10)
    @tweets = Tweet.order(:created_at).page(params[:page]).per(10)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "You've updated with a tweet."
      redirect_to tweets_path
    else
      @tweets = Tweet.all
      @users = User.all
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
