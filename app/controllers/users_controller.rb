class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]  
 
  def tweets
    if @user == current_user
      @tweets = current_user.tweets.order(created_at: :desc)
    else
      @tweets = @user.tweets.order(created_at: :desc)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile Updated "
    else
      flash[:alert] = @user.errors.full_messages.to_sentence

      render :edit
    end
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
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
