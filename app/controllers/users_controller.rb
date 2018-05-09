class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :tweets, :followings, :followers, :likes]

  def tweets
    @users = User.all
    @tweets = @user.tweets.order(created_at: :desc)
    @followings = @user.followings
  end

  def edit
    unless @user == current_user
      flash[:alert] = "非本人，無法編輯!"
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated."
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = "#{@user.errors.full_messages.to_sentence}. Profile was failed to update."
      render :edit
    end

  end

  def followings
    @followings = @user.followings.order(created_at: :desc).page(params[:page]).per(6)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc).page(params[:page]).per(6)
  end

  def likes
    @likes = @user.likes
  end


  private

  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
