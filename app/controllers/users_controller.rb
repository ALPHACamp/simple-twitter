class UsersController < ApplicationController
  before_action :set_user, only:[:tweets, :edit, :update, :followings ,:followers, :likes]

  def tweets
    @tweets = @user.tweets
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully update"
      redirect_to edit_user_path
    else
      flash.now[:alert] = "User was failed to update"
      render :edit
    end
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.like_tweets.all # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
     params.require(:user).permit(:name, :introduction ,:avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
