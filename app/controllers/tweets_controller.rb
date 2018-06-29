class TweetsController < ApplicationController
  before_action :set_tweet, only:[:like, :unlike]
  def index
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(tweets_count: :desc).limit(10) 
    @tweets = Tweet.all
    @ordered_tweets = @tweets.includes(:replies, :likes).order(created_at: :desc)
    @tweet = Tweet.new
  end  

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save(tweet_params)
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end   
  end

  def like
    #set_tweet
    @tweet.likes.create!(user_id: current_user.id)
    redirect_back(fallback_location: tweets_path)
  end

  def unlike
    #set_tweet
    like = Like.where(tweet: @tweet, user: current_user).first
    like.destroy
    redirect_back(fallback_location: tweets_path)
  end

#################
  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end  
end
