class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your profile was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:notice] = "Your profile was failed to update"
      render :edit 
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.all.order("likes.created_at DESC") # 基於測試規格，必須講定變數名稱
    # a = @likes.first.likes.first.created_at
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
