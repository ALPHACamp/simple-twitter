class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    set_user
    
  end

  def update
    set_user
    if @user.id == current_user.id 

      if @user.update(user_params)
        flash[:notice] = "intro was successfully updated"
        redirect_to tweets_user_path(@user)
      else
        flash.now[:alert] = "intro was failed to update"
        render :edit
      end
    else
        flash.now[:alert] = "intro was failed to update : run user"
        render :edit  
    end

  end

  def followings
    set_user
    @followings = @user.followings.includes(:followships).order("followships.created_at DESC") # 基於測試規格，必須講定變數名稱
  end

  def followers
    set_user
    @followers = @user.followers.includes(:inverse_followships).order("followships.created_at DESC")# 基於測試規格，必須講定變數名稱
  end

  def likes
    set_user
    @likes = @user.liked_tweet.includes(:likes).order("likes.created_at DESC")# 基於測試規格，必須講定變數名稱
  end

  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
