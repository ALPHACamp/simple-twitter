class FollowshipsController < ApplicationController
  def create
    if current_user.id.to_s == params[:following_id]
      flash[:alert] = "can't follow my self"
      redirect_back(fallback_location: root_path)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])
      @followship.save
      flash[:notice] = "Successfully followed"
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
