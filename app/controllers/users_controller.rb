class UsersController < ApplicationController

  def tweets
  end

  def edit
    @user = current_user
     #redirect_to tweets_user_path(@user)
    
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

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
