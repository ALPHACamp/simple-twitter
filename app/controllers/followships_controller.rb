class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    @following = User.find(params[:following_id])
    if @followship.save
      # @following.count_followers
      flash[:notice] = "Successfully followed!"
      redirect_back fallback_location: root_path
    else
      flash[:alert] = "Had followed #{@following.name} before."
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @following = User.find(params[:id])
    @followship.destroy
    # @following.count_followers
    flash[:alert] = "Followship was deleted!"
    redirect_back fallback_location: root_path
  end
end
