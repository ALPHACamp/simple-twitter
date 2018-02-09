class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :update, :edit, :likes, :followings, :followers]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to tweets_user_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to edit_user_path(@user)
    end
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
