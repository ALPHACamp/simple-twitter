class UsersController < ApplicationController
  before_action :set_user, only:[:tweets, :edit, :update]

  def tweets
    
  end

  def edit
    unless @user == current_user
      redierct_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully update"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Profile was failed to update"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :avatar)
    end

    def set_user
    @user = User.find(params[:id])
  end

end
