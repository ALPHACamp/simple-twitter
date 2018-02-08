class TweetsController < ApplicationController
  before_action :set_tweet, only:[:like, :unlike]
  def index

    @tweet = Tweet.new 
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    @users = User.order(followers_count: :desc).limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料

  end

  def create
    @user =current_user
    @tweet = @user.tweets.build(tweet_params)
    if@tweet.save
      flash[:notice] = "The tweet was posted."
      redirect_to tweets_path
    elsif @tweet.description.length <=140
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    else
      @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
      @users = User.order(followers_count: :desc).limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
      
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      render :index

    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user).first
    like.destroy
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
