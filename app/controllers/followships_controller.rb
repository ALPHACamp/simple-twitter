class FollowshipsController < ApplicationController
  def create
    @followship = Followship.create(user_id: current_user.id, following_id: params[:following_id])

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = Followship.find(params[:id])
    @followship.destroy

    redirect_back(fallback_location: root_path)
  end
end
