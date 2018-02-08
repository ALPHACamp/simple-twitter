class TweetsController < ApplicationController
  before_action :set_tweet ,only: [:like, :unlike]

  def index
    # @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order('followers_count desc').limit(10)
    # @tweets = Tweet.order('created_at desc').page(params[:page]).per(10)
    @tweets = Tweet.includes(:user, :liked_users).order('created_at desc')
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params) 
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = 'tweet was successfully created'
      redirect_to tweets_path
    else
      flash.now[:alert] = 'tweet was failed to create: ' + @tweet.errors.full_messages.join("<br>").html_safe
      @tweets = Tweet.order('created_at desc').page(params[:page]).per(10)
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    @tweet.user.count_got_likes
    # redirect_back(fallback_location: root_path) # I think this is better
    redirect_to tweets_path  # this doesn't make any fucking sense
  end

  def unlike
    like = Like.where(user: current_user, tweet: @tweet)
    like.destroy_all
    @tweet.user.count_got_likes
    # redirect_back(fallback_location: root_path) # I think this is better
    redirect_to tweets_path  # this doesn't make any fucking sense
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
