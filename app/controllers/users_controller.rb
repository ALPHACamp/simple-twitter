class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to tweets_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="Profiles edit succes"
      redirect_to tweets_user_path(current_user)
    else
      flash[:alert]="Profiles edit error"
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order('followships.updated_at DESC') # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order('followships.updated_at DESC') # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:avatar,:introduction,:name)
  end
end
