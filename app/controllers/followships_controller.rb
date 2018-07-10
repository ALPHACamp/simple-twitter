class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    if @followship
      @followship.destroy
      flash[:alert] = "Followship destroyed"
    else
      flash[:alert] = "No followship"
    end
    redirect_back(fallback_location: root_path)
  end
end
