class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User profile has been updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Fail to update"
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
