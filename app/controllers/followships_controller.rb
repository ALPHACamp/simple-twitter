class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      redirect_back(fallback_location: root_path, notice: "您已將 #{User.find_by(id: params[:following_id]).name} 加入追蹤名單!" )   
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end  
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:alert] = "已取消追蹤#{User.find_by(id: params[:id]).name} !"
    redirect_back(fallback_location: root_path)
  end
end
