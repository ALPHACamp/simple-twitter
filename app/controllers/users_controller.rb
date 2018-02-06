class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :likes]

  def tweets
  end

  def edit
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
    @likes = @user.like_tweets.all.order(created_at: :desc) # 基於測試規格，必須講定變數名稱

  end

  private

  def set_user
    @user = User.find(params)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
