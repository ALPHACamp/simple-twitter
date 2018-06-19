class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create!(tweet_params)
    if @tweet.save
      flash[:notice]="您已經成功發佈一篇推特"
      redirect_to root_path
    else
      flash[:alert]="推特發佈失敗"
      render :new
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
