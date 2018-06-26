class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update]

  def tweets
    
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:notice]= "Info successfully updated."
      redirect_to edit_user_path(@user)
    else
      flash.now[:alert] = "Failed to update info."
      render :edit
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

  def set_user
    @user = User.find(params[:id])
  end

end
