class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
    @users = User.all  # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new 
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def create
     @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
       flash[:notice] = "Tweet created!"
       redirect_back(fallback_location: root_path)
    else
       flash[:alert] = @tweet.errors.full_messages.to_sentence
       redirect_back(fallback_location: root_path)
    end
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
