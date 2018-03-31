class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all.includes(:likes, :user, :liked_users).order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @user = current_user.id
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end


  end

  def like
    @like = Like.create!(user: current_user, tweet: @tweet)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    @likes = Like.where(user: current_user, tweet: @tweet)
    @likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
