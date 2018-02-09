class FollowshipsController < ApplicationController

  def create
    @following = User.find(params[:following_id])

    if @following != current_user
      @followship = Followship.new(following: @following, user: current_user)
      @followship.save
      flash[:notice] = "Followship created"

    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @following = User.find(params[:id])

    @followship = Followship.where(following: @following, user: current_user)
    if @followship
      @followship.destroy_all
      flash[:alert] = "Followship destroyed"
    end
    redirect_back(fallback_location: root_path)
  end

end
