class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new


  end

  def create
    @user = current_user
    @tweet = @current_user.tweets.build(tweet_params)
    @tweet.user = current_user
    
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path

    else
      @tweets = Tweet.all
      render :index
    end
  end

  def like
      @tweet = Tweet.find(params[:id])
      @tweet.likes.create(user: current_user)
      @tweet.likes_count = @tweet.likes_count+1
      @tweet.save
      @tweet.user.save
      @tweet.user.likes_count += 1
      redirect_back(fallback_location: root_path)
  end

  def unlike
      @tweet = Tweet.find(params[:id])
      likes= Like.where(tweet: @tweet, user: current_user)
      @tweet.likes_count = @tweet.likes_count-1
      @tweet.user.likes_count -= 1
      @tweet.save
      @tweet.user.save
      likes.destroy_all
      redirect_back(fallback_location: root_path)
  end



  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end


  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
