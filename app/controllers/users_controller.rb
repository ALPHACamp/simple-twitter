class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update, :tweets, :followings, :followers]
  before_action :can_edit_only_self, only: [:edit, :update]

  def tweets
    @tweets = @user.tweets.user_tweets.page(params[:page]).per(7)
  end
  
  def update
		if @user.update(user_params)
      redirect_to tweets_user_path(@user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
      flash[:alert] = "User was failed to update"
    end
	end

  def followings
    @followings = @user.followings.order(created_at: :asc).page(params[:page]).per(8)
  end

  def followers
    @followers = @user.followers.order(created_at: :asc).page(params[:page]).per(8)
  end

  def likes
    @user = current_user
    @likes = @user.likes.order(created_at: :asc).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def fetch_user
		@user = User.find(params[:id])
  end
  
  def can_edit_only_self
    redirect_to tweets_user_path(@user) unless @user.id == current_user.id
  end
end
