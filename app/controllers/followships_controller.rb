class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.create(following_id: params[:id])
    @followed = User.find(params[:id])
  end

  def destroy
    @followship = current_user.followships.find_by(following_id: params[:id])
    @followed = User.find(params[:id])
    @followship.destroy
  end
end
