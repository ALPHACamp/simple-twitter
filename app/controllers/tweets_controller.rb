class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet,only:[:show, :create, :edit, :update]
  # before_action :authenticate_admin
  def index
    @tweets = Tweet.all
    @users = User.all.limit(10)
    @tweet = Tweet.new
    # @users 
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end


  def show
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
    
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.count_favorites
    redirect_back(fallback_location: root_path)  # 導回上一頁   
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet = @tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save
      redirect_to tweets_path
    
  end


  # def create
  #   @tweet = Tweet.find(params[:user_id])
  #   @tweet = @tweets.build(tweet_params)
  #   @tweet.user = current_user
  #   @tweet.save!
  #   redirect_to tweet_path(@tweet)
  # end

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
