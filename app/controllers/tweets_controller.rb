class TweetsController < ApplicationController

  before_action :set_tweet, only: [:like, :unlike]

  def index
    @users = User.order(followers_count: :DESC).limit(10) # 請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :DESC) # 依排序日期，最新的在前
    @tweet = Tweet.new # 把新增的動作放在index頁面
  end

  def create # 日後確認，為何這樣寫也
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
    	flash[:notice] = "發文成功"
    	redirect_to tweets_path
    else
    	flash[:alert] = "發文失敗了，內容請不要空白"
    	redirect_to tweets_path
    end	
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path) # 導回上一頁
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path) # 導回上一頁
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Strong Parameters
  def tweet_params
  	params.require(:tweet).permit(:description)
  end	

end
