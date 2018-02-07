class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    if current_user != @user
      flash[:alert] = "You can't edit other's profile!"
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User profile was successfully update!"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    @followships = @user.followships.order(created_at: :desc)
  end

  def followers
    @inverse_followships = @user.inverse_followships.order(created_at: :desc)
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end

end
