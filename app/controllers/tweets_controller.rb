class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet created successfully"
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end
  end

 def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
