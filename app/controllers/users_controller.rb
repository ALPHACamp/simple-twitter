class UsersController < ApplicationController
  before_action :set_user
  def tweets

  end

  def edit
  end

  def update
    if @user == current_user
      # only userself can update profile in right format
      if @user.update(user_params)
        redirect_to tweets_user_path(params[:id]), notice: "User's profile was successfully updated"
      else
        render :edit
      end
    else
        redirect_to tweets_user_path(params[:id]), alert: "You can not edit other user's profile!"
    end    
  end

  def followings
    @followings = @user.followings.all # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers =  @user.followers.all # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.page(params[:page]).per(10) # 基於測試規格，必須講定變數名稱
  end
##############3
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
