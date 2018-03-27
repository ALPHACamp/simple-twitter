class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])

    if current_user.id != params[:following_id].to_i
      if @followship = Followship.create(user_id: current_user.id, following_id: params[:following_id])
        flash[:notice] = "Followship was created successfully."
      else
        flash[:alert] = "Followship was failed to create."
      end
    end

    # 更新追蹤者的數量，注意是更新 following 的 followers_count 不是 current_user 的
    # 而且在 destroy 後不能透過關聯方法找那個記錄，所以要在 followship 建立或刪除前，先找出 following user
    # @user.count_followers
    # 最終因爲要因應 rspec 測試時建立 instance 不會透過 controller，因此在 model 階段就要對 @user.count_follower 進行處理

    redirect_back(fallback_location: root_path)
  end

  def destroy
    # 記得這邊的 params 已經被 route 定義爲 :id，情況跟 create 不同
    # 或許可以把 create 的傳入參數也改成 :id ？
    @user = User.find(params[:id])

    @followship = current_user.followships.where(following_id: params[:id]).first
    if @followship.destroy
      flash[:notice] = "Followship was destroyed successfully."
    else
      flash[:alert] = "Followship was failed to destroy."
    end

    # 更新追蹤者的數量
    # @user.count_followers
    # 最終因爲要因應 rspec 測試時建立 instance 不會透過 controller，因此在 model 階段就要對 @user.count_follower 進行處理

    redirect_back(fallback_location: root_path)
  end
end
