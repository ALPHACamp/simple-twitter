class UsersController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update]
  def tweets
    @user_tweets = User.find(params[:id]).tweets
  end

  def update
    if @users.update_attributes(users_params)    
      flash[:notice] = "users was scuccessfully updated"
      redirect_to tweets_user_path(current_user)
    else
      flash.now[:alert] ="users was failed to update"
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

  def set_restaurant
    @users = User.find(params[:id])    
  end

  def users_params
    params.require(:user).permit(:name, :introduction, :avatar)  
  end

end
