class TweetsController < ApplicationController
 
  def index
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc).all
    @users = User.order(followers_count: :desc).limit(10)
    #Top 10
    # 基於測試u規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      redirect_back(fallback_location: tweets_path)
    else
      flash[:alert]= " Tweet text maximum is 140 !"
      redirect_back(fallback_location: tweets_path)
    end
  end


  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    @tweet.count_likes
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    like=@tweet.likes.where(user: current_user)
    like.destroy_all
    @tweet.count_likes
    redirect_back(fallback_location: tweets_path)
  end



  private
  def tweet_params
    params.require(:tweet).permit(:description,:user_id)
  end
  

end
