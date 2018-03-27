class TweetsController < ApplicationController

  def index
    @users = User.all.order(followers_count: :DESC).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet=Tweet.new
    @tweets=Tweet.order(created_at: :desc).page(params[:page]).per(15)
  end

  def create
    @tweet = Tweet.new(tweet_params) #實例變數必須和new相同，這樣才能回傳error訊息回去render
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "您的推特已成功推送"
      redirect_back(fallback_location: tweets_path)
    else
      flash.now[:alert] = "長度太長囉～"
      @users = User.all.order("followers_count DESC").limit(10)
      @tweet=Tweet.new
      @tweets=Tweet.order(created_at: :desc).page(params[:page]).per(10)
      render :index
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_path)  # 導回上一頁
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: tweets_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
