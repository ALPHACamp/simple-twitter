class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all

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
  end

  def unlike
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
