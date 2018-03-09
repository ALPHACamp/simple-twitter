class FollowshipsController < ApplicationController
  def create
    if current_user.id != params[:following_id].to_i
      @followship = Followship.create(user_id: current_user.id, following_id: params[:following_id])
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy

    redirect_back(fallback_location: root_path)
  end
end
