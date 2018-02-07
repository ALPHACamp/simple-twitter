class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :tweets, :followings, :followers]

  def tweets
    @tweets = Tweet.where('user_id' => params[:id])
  end

  def edit
    if @user != current_user
      redirect_to edit_user_path(current_user)
      flash[:alert] = "You cannot edit other users"
    end
  end

  def update
    
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
      flash[:notice] = "user was successfully updated"
    else
      redirect_to edit_user_path(@user)
      flash[:alert] = "user cannot be updated because you missed some fields"
    end
    
  end

  def followings
    @followings = @user.followings
  end

  def followers
    @followers = @user.followers
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
