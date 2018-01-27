class UsersController < ApplicationController
  before_action :setup_user, only: [:edit, :update]

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    byebug
    if @user.update(user_params)
      flash[:notice]="更新成功"
      redirect_to tweets_user_path(@user)
    else
      render :action => :edit
    end
  end

  private

  def setup_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :introduction)
  end
end
