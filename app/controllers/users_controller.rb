class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user)
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
      flash[:notice] = "User was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = "#{@user.errors.full_messages.to_sentence}"
      render :edit
    end 
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
    @user = User.find(params[:id])
    @likes  =  @user.liked_tweets.order(created_at: :desc)
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar)
  end





end
