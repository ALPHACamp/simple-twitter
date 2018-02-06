class UsersController < ApplicationController

  def tweets
  end

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

end
