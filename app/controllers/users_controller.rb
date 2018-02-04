class UsersController < ApplicationController

  def tweets
  end

  def show
    @user = current_user
    @tweets = current_user.tweets.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Your user profile was successfully updated!"    
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

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
