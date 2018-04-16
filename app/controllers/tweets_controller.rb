class TweetsController < ApplicationController
  before_action :set_tweet

  def index
    @tweets = Tweet.order(created_at: :desc)
    @users = User.order(followers_count: :desc).limit(10)
     # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to root_path     
    else
      @tweets = Tweet.order(created_at: :desc)
      render :index
    end

  end

  def show
    @replies = @tweet.replies.order(created_at: :desc)
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    if  params[:id]
      @tweet = Tweet.find(params[:id])
    else
      @tweet = Tweet.new
    end
  end

end
