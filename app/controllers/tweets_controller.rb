class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweet = Tweet.new
    @tweets = Tweet.order(id: :desc)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
