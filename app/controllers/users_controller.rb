class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :likes, :followings]
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end


 
   def update
     @user = User.find(params[:id]) 
     if @user.update(user_params)
      redirect_to tweets_user_path(current_user)
      flash[:note] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
   end

   def followings
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followings = @user.followings.all.order(created_at: :desc)
   end

  def followers
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followers = @user.followers.all.order(created_at: :desc)
  end

  def likes
    # 基於測試規格，必須講定變數名稱
     @user = User.find(params[:id])
     @tweets = @user.liked_tweets
     @likes = @tweets.all.order(created_at: :desc)
  end



 private


  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
