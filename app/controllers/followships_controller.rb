class FollowshipsController < ApplicationController
  def create
    followship = current_user.followships.build(following_id: params[:following_id])
    followship.save

    user = User.find(params[:following_id])
    user.count_followers

    redirect_back(fallback_location: root_path)
  end

  def destroy
    followships = Followship.where(user: current_user, following: params[:id])
    followships.destroy_all

    user = User.find(params[:id])
    user.count_followers
    redirect_back(fallback_location: root_path)
  end
end
