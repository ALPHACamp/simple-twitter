class TweetsController < ApplicationController

  def index
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.page(params[:page]).per(8).order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @users
    @tweets = Tweet.all.order(created_at: :desc)

    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    if @tweet.save
      flash[:notice] = "Tweet was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = "Tweet can't be blank or longer than 140 characters"
      render :index
    end
    
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
