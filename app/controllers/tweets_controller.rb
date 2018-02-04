class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all;
    @tweet = Tweet.new;

    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users  = User.all.limit(10);
  end

  def create
  end

  def like
  end

  def unlike
  end

end
