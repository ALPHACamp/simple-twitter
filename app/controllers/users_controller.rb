class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  #個別user的推播與簡介
  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to edit_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc)
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = @user.liked_tweets.order(created_at: :desc)
  end

  private 
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
