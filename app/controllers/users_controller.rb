class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)

  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tweets_user_path(current_user), alert: "Can't edit other's profile"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "Profile updated"
        redirect_to edit_user_path
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "Can't edit other's profile"
      redirect_to edit_user_path
    end
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = User.find(params[:id]) # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
