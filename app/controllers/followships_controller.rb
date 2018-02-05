class FollowshipsController < ApplicationController
  before_action :set_following, only: [:create ,:destroy]

  def create
    if @following != current_user
      @followship = Followship.new(following: @following, user: current_user)
      @followship.save
      @following.update_follower_count
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    followship = current_user.followships.where(following_id: params[:following_id])
    followship.destroy_all
    @following.update_follower_count
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_following
    @following = User.find(params[:following_id])
  end

end
