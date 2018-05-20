class FollowshipsController < ApplicationController
  def create

    @following = User.find(params[:following_id])
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @following != current_user
      @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "不能追蹤自己"
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
