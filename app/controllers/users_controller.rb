class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

end
