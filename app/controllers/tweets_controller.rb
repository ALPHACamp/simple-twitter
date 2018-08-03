class TweetsController < ApplicationController
# 登入認證
before_action :authenticate_user!
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new #在index建立tweet容器來建立短文
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    # 必須搭配counter_cache才年通過測試
    @users = User.order(followers_count: :desc).limit(10)
    # 以下也可以通過自動測試  
    #@users = User.all.sort_by {|user| user.followers.size}.reverse.first(10)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweeted successfully"
      redirect_to tweets_path
    else
      flash.now[:alert] = "Tweeted faield"
      render :index
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path) #導回上一頁
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
