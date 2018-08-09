class TweetsController < ApplicationController
  def index
   @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
   @tweet = Tweet.new
   @tweets = Tweet.order(created_at: :desc)

  end

  def create 
    @tweet = current_user.tweets.build(description_params)
    @tweet.save!
    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def description_params
    params.require(:tweet).permit(:description)
    
  end

end
