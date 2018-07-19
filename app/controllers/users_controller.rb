class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was successfully created"
      redirect_to tweets_user_path(current_user)
    else
      flash[:alert] = "user was failed to create"
      render :edit
    end
  end

  def followings
    @followings = @user.followings
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets
    # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
