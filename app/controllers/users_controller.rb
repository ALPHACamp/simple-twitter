class UsersController < ApplicationController

  def tweets
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "User profile was successfully update!"
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

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end

end
