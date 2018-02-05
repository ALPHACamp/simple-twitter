class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to tweets_user_path(current_user)
      flash[:notice] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followings 
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followers 
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @tweets = @user.liked_tweets
    @likes = @user.likes.all
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
