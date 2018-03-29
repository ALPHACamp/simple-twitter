class FollowshipsController < ApplicationController
  def create
    if followship_params[:following_id] == current_user.id.to_s
      flash[:alert] = "You can't follow yourself"
      redirect_to tweets_user_path(current_user)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])
      @following = User.find(params[:following_id])
      if @followship.save
        flash[:notice] = "Successfully followed!"
        redirect_back fallback_location: root_path
      else
        flash[:alert] = "Had followed #{@following.name} before."
        redirect_back fallback_location: root_path
      end
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @following = User.find(params[:id])
    @followship.destroy
    # @following.count_followers
    flash[:alert] = "Followship was deleted!"
    redirect_back fallback_location: root_path
  end

  private

  def followship_params
    params.permit(:following_id)
  end
end
