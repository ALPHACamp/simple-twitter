class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  def followings
    @followings = @user.followships.order(created_at: :desc)
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
