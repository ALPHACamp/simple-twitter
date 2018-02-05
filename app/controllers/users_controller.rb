class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User profile was successfully update!"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end

end
