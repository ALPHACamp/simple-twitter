class FollowshipsController < ApplicationController
  def create
    if params[:following_id] == current_user.id
      flash[:alert] = "You can't follow yourself!"
      redirect_back(fallback_location: root_path)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])

      if @followship.save
        current_user.count_followings
        User.find(params[:following_id]).count_followers

        flash[:notice] = "Successfully followed"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    current_user.count_followings
    User.find(params[:id]).count_followers

    flash[:alert] = "Unfollowed"
    redirect_back(fallback_location: root_path)
  end
end
