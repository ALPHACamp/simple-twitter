class TweetsController < ApplicationController

  def index
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @users = User.order(created_at: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
       flash[:notice] = "Tweet created!"
       redirect_to tweets_path
    else
       flash[:alert] = @tweet.errors.full_messages.to_sentence
       redirect_back(fallback_location: root_path)
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to  tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
