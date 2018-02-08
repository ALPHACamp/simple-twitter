class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
    @followers = @user.followers
  end

  def edit
    unless @user == current_user
      flash[:alert] = "Not allow!"
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    flash[:success] = "Great! Your profile was updated successfully."
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order(followers_count: :desc).limit(10)
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
