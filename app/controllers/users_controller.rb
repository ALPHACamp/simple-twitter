class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def followings
    @followings = current_user.followings.all # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = current_user.followers.all # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = current_user.likes # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
