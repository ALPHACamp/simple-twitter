class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like ,:unlike]
  after_action :update_count , only: [:like, :unlike]

  def index
    @tweets = Tweet.all
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料

    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Successfully tweeted"
      redirect_to tweets_path
    else
      flash.now[:alert] = @tweet.errors.full_messages.to_sentence if @tweet.errors.any?
      @tweets = Tweet.all
      render :index
    end
  end

  def like
    Like.create(tweet: @tweet , user: current_user)
    redirect_to tweets_path
  end

  def unlike
    like = Like.where(tweet: @tweet , user: current_user)
    like.destroy_all
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def update_count
    @tweet.update_count
    @tweet.user.update_count
    current_user.update_count
  end
end
