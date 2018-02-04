class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(followers_count: :desc).limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Created successfully!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "False to create"
      render 'index'
    end
  end

  def like
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
