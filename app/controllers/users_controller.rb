class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :update, :tweets, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.user_tweets.page(params[:page]).per(7)
  end
  
  def update
		if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
      flash[:alert] = "User was failed to update"
    end
	end

  def followings
    @followings = @user.followings.order(created_at: :desc).page(params[:page]).per(8)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc).page(params[:page]).per(8)
  end

  def likes
    @likes = @user.likes.order(created_at: :desc).page(params[:page]).per(7)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def fetch_user
		@user = User.find(params[:id])
	end
end
