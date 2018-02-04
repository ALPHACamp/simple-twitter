class UsersController < ApplicationController
  before_action :set_user, only: [:tweets,:followings,:followers,:edit,:update]
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if @user.update(user_params)
      redirect_to session.delete(:return_to)
      flash[:notice] = "User profile was successfully updated"
    else
      render :edit
      flash[:alert] = "User profile was failed to update"
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
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
