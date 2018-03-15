class TweetsController < ApplicationController  
  
  def index
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Tweet successfully created"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong"
      render :index
    end
  end
  
  #讓tweets可以被喜歡
  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  #讓tweets可以取消喜歡
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
