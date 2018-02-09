class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = Tweet.where(user_id: params[:id])
  end

  def edit
    if @user != current_user
      redirect_to tweets_user_path(@user)
    end

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "User was failed to update"
      render:edit
    end
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = Like.where(user_id: params[:id]).order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
