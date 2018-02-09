class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = Tweet.where(user: @user)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end     
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = "#{@user.errors.full_messages.to_sentence}"
      render :edit
    end 
  end

  def followings
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
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
