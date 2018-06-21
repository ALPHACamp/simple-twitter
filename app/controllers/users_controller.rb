class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end
 
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="資料成功被編輯"
      redirect_to tweets_user_path(current_user)
    else
      flash[:alert]="未編輯成功，名字不能為空白"
      render :edit
    end
  end

  def followings 
    @user = User.find(params[:id])
    @followings = @user.followings.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
  end
 
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private
  def user_params
    params.require(:user).permit(:avatar,:introduction,:name)
  end

end
