class FollowshipsController < ApplicationController
  def create
    # 需要設定前端的 link_to，在發出請求時送進 following_id
  	@followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
  def destroy
    @followship = current_user.followships.where(following_id:params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
    #複數寫法
    # @followship = current_user.followships.where(following_id: params[:id])
    # @followship.destroy_all
  end
end
