class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id:params[:following_id])
    if @followship.user_id != @followship.following_id
      @followship.save
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id:params[:id])
    @followship.destroy_all
    redirect_back(fallback_location: root_path)
  end
end
