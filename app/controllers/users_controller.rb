class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def tweets
  end

  def edit
    unless @user == current_user
      flash[:alert] = "非本人，無法編輯!"
      redirect_to root_path
    end
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


  private

  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
