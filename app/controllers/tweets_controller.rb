class TweetsController < ApplicationController
  before_action :set_tweet, only:[:like, :unlike]

  def index
    @tweets = Tweet.includes(:user, :likes, :liked_users).order(created_at: :desc)
    @tweet = Tweet.new
    @users = User.order(followers_count: :desc).limit(10)

    #基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save!
      redirect_to tweets_path
    else
      @tweet = Tweet.order(created_at: :desc)
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

    #like = Tweet.where(tweet: @tweet, user:current_user)
    #@like.destroy_all
    #redirect_back(fallback_location: root_path)
  end


  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
