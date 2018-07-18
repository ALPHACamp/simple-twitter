class UsersController < ApplicationController

  def tweets
  end


  def edit
    @user = User.find(params[:id])
    
    unless @user.name 
      @user.name = @user.email.split('@').first
    end
    
    unless @user.id == current_user.id
      flash[:notice] = "Don't Allow!";
      # redirect_to user_path(@user)
      redirect_back(fallback_location: tweets_user_path(current_user))
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #redirect_to user_path(@user.id)
      redirect_back(fallback_location: tweets_user_path(@user))
      flash[:notice] = "user was successfully updated"
    else
      redirect_back(fallback_location: tweets_user_path(@user))
      flash[:alert] = "failed"
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

end
