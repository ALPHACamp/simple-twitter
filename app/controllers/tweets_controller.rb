class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.js
        # redirect_to tweets_path
      else
        flash[:alert] = @tweet.errors.full_messages.to_sentence
        format.html {redirect_to tweets_path}
      end
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    @tweet = Tweet.find(params[:id])
    # redirect_back fallback_location: root_path
  end

  def unlike
    @like = Like.where(user: current_user, tweet: @tweet).first
    @like.destroy
    @tweet = Tweet.find(params[:id])
    # redirect_back fallback_location: root_path
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
