class TweetsController < ApplicationController
  def index
    @users = User.order(followers_count: :desc).limit(10)
    @allusers = User.all
     # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    #3.使用者能瀏覽所有的推播 (tweet)
    @allTweets = Tweet.all
    @user = User.find(current_user.id)
    @tweet = Tweet.new
  end

  def replies
  
  end

  def create
    @user = User.find(current_user.id)
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_back(fallback_location: root_path)
  end

  def like
    @like = Like.build(user_id: current_user.id,tweet_id: params[:tweet_id])
    if @like.save
      redirect_to :back
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @like.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def unlike
    @like = Like.where(user_id: current_user.id,tweet_id: params[:id]).first
    @like.destroy
    flash[:alert] = "like destroyed"
    redirect_to :back
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
