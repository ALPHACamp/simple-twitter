class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = "成功推播(tweet)"
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
