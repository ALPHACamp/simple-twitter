class TweetsController < ApplicationController

  def index
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.all
    @tweet = Tweet.new # 把新增的動作放在index頁面
  end

 def create # 日後確認，為何這樣寫也
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
    	flash[:notice] = "發文成功"
    	redirect_to tweets_path
    else
    	flash[:alert] = "發文失敗了，內容不可以空白不填喔"
    	redirect_to tweets_path
    end	
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path) # 導回上一頁
  end

  def unlike
  end

  private

  # Strong Parameters
  def tweet_params
  	params.require(:tweet).permit(:description)
  end	

end
