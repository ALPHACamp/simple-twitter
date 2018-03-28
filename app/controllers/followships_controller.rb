class FollowshipsController < ApplicationController
  def create
    following = User.find(params[:following_id])
    if current_user != following
      @followship = current_user.followships.build(following_id: params[:following_id])

      if @followship.save
        flash[:notice] = "Successfully followed"
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    if @followship.size == 0
      flash[:alert] = "No followship for user is destroyed"
    else
      @followship.destroy_all
      flash[:alert] = "Followship destroyed"
    end
    redirect_back(fallback_location: root_path)
  end
end
