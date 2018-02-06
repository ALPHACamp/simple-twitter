class FollowshipsController < ApplicationController
  after_action :update_count , only: [:create, :destroy]

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

  private

  def update_count
    @following.update_count
    current_user.update_count
  end

end
