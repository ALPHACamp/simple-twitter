class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets.all
  end

  def edit
    redirect_to tweets_user_path(@user) if @user != current_user
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence if @user.errors.any?
      render :edit
    end
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.all # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
