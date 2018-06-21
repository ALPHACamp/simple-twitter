class TweetsController < ApplicationController

  def index  
    @users = User.order(followers_count: :desc).limit(10) 
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
  end 

  def create
    @tweet = Tweet.create(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice]="您已經成功發佈一篇推特"
      redirect_to tweets_path
      #redirect_to root_path
    else
      flash[:alert]="推特內容不能空白"
      redirect_to tweets_path
      #redirect_to root_path
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    Like.create(user:current_user, tweet:@tweet)    
    #redirect_back(fallback_location: root_path)  
    redirect_back(fallback_location: tweets_path)  # 導回上一頁
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    unlike = Like.where(user:current_user, tweet:@tweet).first
    unlike.destroy    
    #redirect_back(fallback_location: root_path) 
    redirect_back(fallback_location: tweets_path)  # 導回上一頁
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
