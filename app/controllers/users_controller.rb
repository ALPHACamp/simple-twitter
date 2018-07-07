class UsersController < ApplicationController
  before_action :authenticate_owner, only: [:update]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tweeted_tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "user was failed to update"
      render :edit
    end
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def authenticate_owner
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:alert] = "Not allow!"
      redirect_to user_path(@user)
    end
  end

end
