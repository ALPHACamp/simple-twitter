class FollowshipsController < ApplicationController
  def create
    @followship = Followship.new(user_id: current_user.id, following_id: params[:following_id])
    @followship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(params[:id])
    @followship.destroy_all
    redirect_back(fallback_location: root_path)
  end


  private
  def followship_params
    params.require(:followship).permit(:user_id, :following_id)

  end
end
