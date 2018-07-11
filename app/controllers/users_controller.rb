class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    if current_user != @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was sucessfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = "user was failed to update"
      render :edit
    end
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
