class UsersController < ApplicationController




  def tweets
    @tweets = User.find(params[:id]).tweets
  end

  def edit
  end

  def update
  end

  def followings
    @followings=User.find(params[:id]).followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end



end
