class UsersController < ApplicationController
  before_action :set_user ,only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order('created_at desc').page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user != current_user
      flash.now[:alert] = 'Not able to edit other\'s profile!'
      redirect_back(fallback_location: root_path)
    end

    if @user.update(user_params)
      flash[:notice] = "User porfile was successfully update"
      redirect_to edit_user_path(current_user)
    else
      flash.now[:alert] = 'Update failed!'
      render :edit
    end
  end

  def followings
    # @followings # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.order('followships.created_at desc').page(params[:page]).per(6)
  end

  def followers
    # @followers # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.order('followships.created_at desc').page(params[:page]).per(6)
  end

  def likes
    # @likes # 基於測試規格，必須講定變數名稱
    @likes = @user.likes_tweets.order('likes.created_at desc')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
