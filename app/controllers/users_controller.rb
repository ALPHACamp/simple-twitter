class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    unless @user === current_user
      redirect_to root_path 
    end
  end

  def update
    @user = User.find(params[:id]) 
    @user.update(user_params)
    redirect_to root_path
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

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end



end
