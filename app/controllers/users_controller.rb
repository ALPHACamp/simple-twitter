class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets.all
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Successfully updated'
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence if @user.errors.any?
      render :edit
    end
  end

  attr_reader :followings

  attr_reader :followers

  attr_reader :likes

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end
end
