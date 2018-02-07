class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.create(following_id: params[:id])
  end

  def destroy
    @followship = current_user.followships.find_by(following_id: params[:id])
    @followship.destroy
  end
end
