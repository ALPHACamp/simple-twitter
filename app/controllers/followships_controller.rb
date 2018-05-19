class FollowshipsController < ApplicationController
  def create
    @followship = Followship.new(user: current_user, following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # where 會回傳物件集合(Array)
    followships = Followship.where(user: current_user, following_id: params[:id])
    followships.destroy_all
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
