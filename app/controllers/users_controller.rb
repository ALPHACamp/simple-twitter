class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :tweets, :followings, :followers, :likes]

  def tweets
    #@user = User.find(params[:user_id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def show
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "update successfully"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Update failed! Maybe this name has already been taken, try another name."
      render :edit
    end
  end

  def followings
    #@followings = @user.followings.order(created_at: :desc) # 基於測試規格，必須講定變數名稱

    @followings = @user.followings.order('followships.created_at DESC')
  end

  def followers
    #@followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱

    @followers = @user.followers.order('followships.created_at DESC')
  end

  def likes
    #@likes = @user.liked_tweets.order(created_at: :desc) # 基於測試規格，必須講定變數名稱

    @likes = @user.liked_tweets.order('likes.updated_at DESC')
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
