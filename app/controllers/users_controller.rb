class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    if @user != current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice]= "Info successfully updated."
      redirect_to edit_user_path(@user)
    else
      flash.now[:alert] = "Failed to update info."
      render :edit
    end
  end

  def followings
    @followings =  @user.followings.order('followships.created_at DESC').page(params[:page]).per(6)
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC').page(params[:page]).per(6)
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order('likes.created_at DESC').page(params[:page]).per(5)
    # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
