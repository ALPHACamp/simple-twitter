class UsersController < ApplicationController
  before_action :set_user
  
  def tweets
    @tweets = @user.tweets.order("tweets.created_at desc")
  end

  def edit
    unless @user == current_user
      redirect_to edit_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated."
    else
      flash[:alert] = "Something is wrong! Your name can't be blank!"
    end
    redirect_to edit_user_path(@user)
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.order("followships.created_at desc")
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.order("followships.created_at desc")
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = @user.likes.order("likes.created_at desc")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
  
end
