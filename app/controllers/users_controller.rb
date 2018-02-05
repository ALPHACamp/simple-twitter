class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user)
    @user.likes_count = @user.likes.size

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to tweets_user_path
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.all  # 基於測試規格，必須講定變數名稱
    @tweets = Tweet.where(user_id: @user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
