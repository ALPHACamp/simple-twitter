class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    # 每頁10則tweet，按時間排序
    @tweets = Tweet.order(updated_at: :desc).page(params[:page]).per(10)
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    # 新增關聯物件時，使用 buile 而不是 new，新增關聯物件後需要搭配 save 存入 DB 
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to root_path
    else
      flash[:alert] = "tweet was failed to created"
      render :index
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
