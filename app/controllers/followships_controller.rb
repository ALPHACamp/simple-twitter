class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
      user = User.find(params[:following_id])
      user.increment(:followers_count, 1)
      user.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    user = User.find(params[:id])
    user.decrement(:followers_count, 1)
    user.save
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
