class TweetsController < ApplicationController

  def index
    @tweets = User.find(current_user.id).tweets.order(created_at: :desc)
    @tweet = Tweet.new
    @users = User.all.limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet created successfully"
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  def like
  end

  def unlike
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
