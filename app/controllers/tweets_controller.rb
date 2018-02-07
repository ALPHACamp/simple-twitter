class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
     @tweet = current_user.tweets.build(tweet_params)
     if @tweet.save
      redirect_to tweets_path
     else
       flash[:alert] = @tweet.errors.full_messages.to_sentence
       @tweets = Tweet.all.order(created_at: :desc)
       render :index
     end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweet_replies_path(@tweet)  # 導回上一頁
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def tweet_params
      params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
