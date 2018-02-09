class TweetsController < ApplicationController
  
  def index
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_back(fallback_location: tweets_path)  # 導回上一頁
    else
      flash.now[:alert] = "tweet was failed to create"
      redirect_to tweets_path
    end    
    
  end
  
  def like
    tweet = Tweet.find(params[:id])
    tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    tweet = Tweet.find(params[:id])
    like = Like.find_by("tweet_id" => tweet.id, "user_id" => current_user.id)
    tweet.user.count_likes
    if like
      like.destroy
      #redirect_to tweets_path
      redirect_back(fallback_location: root_path)  # 導回上一頁
    end
  end
  
  private
  
  def tweet_params
    params.require(:x).permit(:description, :user_id)
  end  

end
