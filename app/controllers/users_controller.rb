class UsersController < ApplicationController
  before_action :set_user, only: [:tweets,:followings,:followers,:edit,:update,:likes]
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if @user.update(user_params)
      redirect_to session.delete(:return_to)
      flash[:notice] = "User profile was successfully updated"
    else
      
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    
    @followings = @user.followings.order(updated_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    
    @followers = @user.followers.order(updated_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes =@user.liked_tweets.order(updated_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


  def set_user
    @user = User.find(params[:id])
  end
end
