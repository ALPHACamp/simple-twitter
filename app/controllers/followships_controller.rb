class FollowshipsController < ApplicationController
  def create
    @following = User.find(params[:following_id])
    if @following != current_user
      @followship = Followship.new(following: @following, user: current_user)
      @followship.save
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    followship = current_user.followships.where(following_id: params[:following_id])
    followship.destroy_all
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
