class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
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
  
    
  def edit
    @user = User.find(params[:id])
    
    unless @user.name 
      @user.name = @user.email.split('@').first
    end
    
    unless @user.id == current_user.id
      flash[:notice] = "你沒有權限";
      redirect_to user_path(@user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "user was successfully updated"
    else
      render :edit
      flash[:alert] = "user was failed to update"
    end
  end
  
  private
  
  def user_params
    params.
      require(:user).
      permit(:name, 
        :intro, 
        :avatar)
  end

end
