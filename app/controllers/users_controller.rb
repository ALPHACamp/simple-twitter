class UsersController < ApplicationController




  def tweets
    @tweets = User.find(params[:id]).tweets
  end

  def edit
    @user=User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings=User.find(params[:id]).followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers=User.find(params[:id]).followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes=User.find(params[:id]).likes # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

end
