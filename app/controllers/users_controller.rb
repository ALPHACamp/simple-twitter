class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to tweets_user_path(@user) unless @user == current_user
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
