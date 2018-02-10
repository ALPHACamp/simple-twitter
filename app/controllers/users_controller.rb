class UsersController < ApplicationController
  before_action :set_user, only: [ :tweets,:edit, :update, :followings, :followers, :likes]
  def tweets
    @tweets = Tweet.all
  end

  def edit
  end

  def update

    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  def followings
    @followings = @user.followings.order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order("likes.created_at desc")# 基於測試規格，必須講定變數名稱
  end



private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
