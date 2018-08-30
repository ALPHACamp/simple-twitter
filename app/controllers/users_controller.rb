class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweet = @user.tweets.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Profile was failed to update"
      render :edit
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = @user.liked_tweets
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
