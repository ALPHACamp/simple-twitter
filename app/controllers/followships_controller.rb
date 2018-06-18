class FollowshipsController < ApplicationController
  def create #follow
    following = User.find(params[:following_id])
    @followship = current_user.followships.build(following_id: params[:following_id])

    if following != current_user
      if @followship.save
        flash[:notice] = "Successfully followed"
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy #unfollow
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
