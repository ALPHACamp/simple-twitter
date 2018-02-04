class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new #寫一篇tweet
  end
  def create
    @tweet = Tweet.new(tweet_params)
    user = current_user
    if @tweet.save
      flash[:notice] = '新增成功'
      redirect_to tweets_path
    else
      render action: :index
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
