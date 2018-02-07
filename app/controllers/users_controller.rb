class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def show
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Your user profile was successfully updated!"    
  end

  def followings
    @followings = @user.followships.all.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.inverse_followships.all.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes=@user.likes.all.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

end
