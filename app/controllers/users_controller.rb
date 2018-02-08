class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    # set_user
    @tweets = Tweet.where(user_id: params[:id]).order(created_at: :desc)
  end

  def edit
    # set_user
    if current_user != @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    # set_user
    if current_user == @user
      if @user.update_attributes(user_params)
        redirect_to root_url, :notice => "個人資料更新成功"
      else
        render :action => :edit
      end
    else
      redirect_to root_url, :alert => "您非該使用者，無法更變該使用者資料"
    end
  end

  def followings
    # set_user
    @followings = @user.followings
  end

  def followers
    # set_user
    @followers = @user.followers
  end

  def likes
    # set_user
    @likes = @user.liked_tweets
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
