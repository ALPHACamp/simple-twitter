class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(:name).limit(10)
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Tweet was successfully added."
      redirect_to tweets_path
    else
      @tweet = Tweet.all

      render :index
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create(user: current_user)
    redirect_back(fallback_location: request.referrer)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: request.referrer)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
