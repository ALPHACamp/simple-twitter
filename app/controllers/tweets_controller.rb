class TweetsController < ApplicationController

  def index
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order("users.followers_count desc").limit(10)
    @tweets = Tweet.order("tweets.created_at desc").all
    @tweet = current_user.tweets.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet posted."
    else
      flash[:alert] = "Something is wrong! Maximum tweet length is 140 characters!"
    end
    redirect_to root_path
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
