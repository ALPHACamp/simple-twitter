class FollowshipsController < ApplicationController
  
  def create
    if params[:following_id] == current_user.id
      flash[:notice] = "不允許追蹤自己！"
      redirect_back(fallback_location: root_path)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])
      if @followship.save
        @user = User.find(@followship.following_id)
        flash[:notice] = "成功追蹤！"
        redirect_back(fallback_location: root_path)
      end  
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "你不再追蹤對方囉"
    redirect_back(fallback_location: root_path)
  end
end