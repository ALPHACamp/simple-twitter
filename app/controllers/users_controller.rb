class UsersController < ApplicationController

  def tweets
    @user=User.find(params[:id])
    @tweets=User.find(params[:id]).tweets.order("updated_at DESC")
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    
    if @user=User.update(usr_params)
      flash[:notice] = "更新成功"
      
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] =@user.errors.full_messages.each{|msg| msg.class}

      render :edit
    end     
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @user=User.find(params[:id])
    @followings=User.find(params[:id]).followings.order("updated_at DESC")    
  end

  def followers
     # 基於測試規格，必須講定變數名稱
    @user=User.find(params[:id])
    @followers=User.find(params[:id]).followers.order("updated_at DESC")
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @user=User.find(params[:id])
    @likes=[]
    @likes_t=User.find(params[:id]).likes.order("updated_at DESC").each{|t| @likes << t.tweet}
  end

  private

  def usr_params
    params.require(:user).permit(:name,:introduction,:avatar)
  end

end
