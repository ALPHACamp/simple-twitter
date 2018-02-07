class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet,only:[:show, :edit, :update]
  # before_action :authenticate_admin
  def index
    @tweets = Tweet.all
    @users = User.all
    # @users 
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
  end


  def create
    @tweet = Tweet.find(params[:tweet_id])
    @tweet = @tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_to tweet_path(@tweet)
  end

  def like
  end

  def unlike
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])  
  end

  def tweet_params
    params.require(:tweet).permit(:name, :description)
  end


end
