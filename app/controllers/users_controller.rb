class UsersController < ApplicationController
  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to root_path
    
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.all.order(created_at: :desc).limit(6)# 基於測試規格，必須講定變數名稱

  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.all.order(created_at: :desc).limit(6)# 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.all.order(created_at: :desc).limit(10)  # 基於測試規格，必須講定變數名稱
  end

  private


  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
