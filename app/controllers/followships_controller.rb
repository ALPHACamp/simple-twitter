class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.new(following_id: params[:following_id])
    @followship.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    redirect_back(fallback_location:root_path)
  end
end
