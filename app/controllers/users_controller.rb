class UsersController < ApplicationController
	before_action :set_user, only: [ :edit, :update, :tweets]
  def tweets
    @followings = @user.followings.order(created_at: :desc)
    @followers = @user.followers.order(created_at: :desc)
    @likes = @user.likes.order(created_at: :desc)
  end
  def edit
    unless @user == current_user
      redirect_to tweets_user_path(current_user), alert: "Can't edit other's profile"
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "Profile updated"
        redirect_to root_path
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "Can't edit other's profile"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end

