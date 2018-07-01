class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.new(following_id:params[:following_id])
    if @followship.save
      flash[:notice] = "You are following him/her now!"
      redirect_back(fallback_location: request.referrer)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: request.referrer)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:alert] = "Followship deleted."
    redirect_back(fallback_location: request.referrer)
  end
end
