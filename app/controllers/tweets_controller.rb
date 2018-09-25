class TweetsController < ApplicationController

  before_action :set_tweet, only: [:like, :unlike, :destroy]

  def index
    @tweet = Tweet.new
    # 每頁10則tweet，按時間排序
    @tweets = Tweet.order(updated_at: :desc).page(params[:page]).per(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    # 新增關聯物件時，使用 buile 而不是 new，新增關聯物件後需要搭配 save 存入 DB 
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to :tweets
    else
      flash[:alert] = "tweet was failed to created"
      render :index
    end
  end

  def like
    # 先用 params[:id] 取出tweet物件, 新建一筆 Like 紀錄，並設定 tweet_id 和 user_id 的外鍵。
    Like.create(tweet: @tweet, user: current_user)
    # @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: :tweets)
  end

  def unlike
    # 因為有多個條件所以使用 where 來操作
    likes = Like.where(tweet: @tweet, user: current_user)
    # 而刪除集合要搭配 destroy_all 來使用
    likes.destroy_all
    redirect_back(fallback_location: :tweets)
  end

  def destroy
    if current_user.admin? || current_user == @tweet.user
      @tweet.destroy
      redirect_to root_path
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
