class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    # 每頁10則tweet，按時間排序
    @tweets = Tweet.order(updated_at: :desc).page(params[:page]).per(10)
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
  end

  def like
  end

  def unlike
  end

end
