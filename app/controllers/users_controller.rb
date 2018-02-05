class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :update]

  def tweets
  end

  def update
		if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
      flash[:alert] = "User was failed to update"
    end
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

  def fetch_user
		@user = current_user
	end
end
