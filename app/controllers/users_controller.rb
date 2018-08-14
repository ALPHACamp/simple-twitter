class UsersController < ApplicationController
  before_action :set_user, only:[:tweets, :edit, :update]

  def tweets
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully update"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Profile was failed to update"
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.all
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.all
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :avatar)
    end

    def set_user
    @user = User.find(params[:id])
  end

end
