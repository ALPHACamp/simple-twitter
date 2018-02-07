class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user.update(user_params)
  end

  def followings
    @followings = current_user.followings.all # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = current_user.followers.all # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = current_user.like_tweets.all # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
