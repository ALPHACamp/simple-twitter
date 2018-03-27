class UsersController < ApplicationController
  before_action :set_user, :check_userself, :only => [:tweets, :edit, :update, :followings ]
  before_action :check_userself, :only => [:edit, :update]

  def tweets
    @tweets = @user.tweets
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "資料已更新！"
      redirect_to tweets_user_path      
    else
      render :edit
      flash[:alert] = "資料更新失敗！"
    end
  end

  def followings
    @user = current_user
    @followings = @user.followings  # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = current_user
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = current_user
    @likes = @user.likes_tweets  # 基於測試規格，必須講定變數名稱
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :name, :introduction, :avatar)
    end

    def check_userself
      if current_user!=@user
      redirect_to restaurants_path
      flash[:alert] = "您無編輯權限！"
      end
  end

end
