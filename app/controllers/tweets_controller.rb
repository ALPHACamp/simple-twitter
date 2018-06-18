class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]

  def index
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user #重要
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end
  end

  def like
    #@tweet = Tweet.find(params[:id])
    if @tweet.is_liked?(current_user)
      flash[:alert] = "already liked"
    else
      @tweet.likes.create!(user: current_user)
    end
    redirect_to tweets_path
  end

  def unlike
    #@tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
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
