class UsersController < ApplicationController

  def tweets
    @tweets = Tweet.where(user: params[:id])
    @user = User.find(params[:id])
  end

  def edit
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
    @likes = current_user.likes.all # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
  end

end
