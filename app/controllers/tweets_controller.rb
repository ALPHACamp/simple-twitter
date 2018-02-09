class TweetsController < ApplicationController

  def index
     #@tweets = Tweet.all.order(created_at: :desc)
     @tweets = Tweet.all
     @tweet = Tweet.new
     @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end
  

  def create
    #@tweet = Tweet.create(tweet_params)
    #@tweet.user = current_user
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Successfully tweeted"
      redirect_to tweets_url
    else
      flash.now[:alert] = @tweet.errors.full_messages.to_sentence if @tweet.errors.any?
      #@tweets = Tweet.all
     
    end  
   
  end
  
  # POST /tweets/:id/like
  def like
    @tweet= Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)  # 導回上一頁
  end
  # POST /tweets/:id/unlike
  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
