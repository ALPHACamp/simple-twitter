class FollowshipsController < ApplicationController

  def create
      @followship = current_user.followships.new(following_id: params[:following_id])

      if @followship.save
        flash[:notice] = "Successfully followed"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
  end

  def destroy
    # 當使用 where 方法時，無論資料有幾筆，他都會回傳一組物件集合（也就是陣列）
    @followship =current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:alert] = "followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
