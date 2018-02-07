class UsersController < ApplicationController

  before_action :set_user

  def tweets
    @tweets = @user.tweets
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to tweets_user_path(@user)
      flash[:notice] = "User was successfully update."
    else
      render :edit
      flash.now[:alert] = "User was failed to update."
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
