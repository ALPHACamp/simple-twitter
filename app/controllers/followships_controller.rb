class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id:params[:id])
    if @followship.length>0
      @followship.destroy_all
      flash[:alert] = "Followship destroy"
    else
      flash[:alert] = "no Followship!"
    end

    redirect_back(fallback_location: root_path)
  end
end
