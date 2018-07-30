class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  
  

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @users = User.order(followers_count: :desc).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Tweet Update"
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path 
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path 
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
