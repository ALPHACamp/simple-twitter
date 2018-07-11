class TweetsController < ApplicationController

  def index
    @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = current_user.tweets.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      flash[:notice] = "tweet was successfully created"
    else
      flash[:alert] = "tweet should be less than 140 words"
    end
    redirect_to tweets_path
  end

  def like
    tweet = Tweet.find(params[:id])
    tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
