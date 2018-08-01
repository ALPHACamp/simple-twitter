class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="user was successfully updated"
      redirect_to tweets_user_path
    else
      flash[:alert] ="user was failed to update"
      render :edit
    end
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @user.count_likes
    @likes = @user.liked_tweets.all.order(created_at: :desc)
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
