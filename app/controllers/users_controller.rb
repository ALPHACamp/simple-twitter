class UsersController < ApplicationController

  def tweets
  @user  = User.all
  @user = User.find(params[:id])
  end

  def edit
  @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  @user.update_attributes(user_params)
  redirect_to tweets_user_path(current_user)
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
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
