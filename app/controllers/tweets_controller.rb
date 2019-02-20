class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc) # .limit(10)
    @tweet = Tweet.new
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path

    else
      flash.now[:alert] = "Did you miss something?"
      @users = User.order(followers_count: :desc).limit(10)
      @tweets = Tweet.order(created_at: :desc)
      redirect_to(assigns(:tweets))
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)  # 導回上一頁
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def tweet_params
    # puts "enter the strong params"
    params.require(:tweet).permit(:description)
  end
end
