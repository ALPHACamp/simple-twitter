class FollowshipsController < ApplicationController
  def create
    if current_user.id != params[:following_id].to_i
      @followship = current_user.followships.build(following_id: params[:following_id])
      @following = User.find(params[:following_id])

      if @followship.save
        flash[:notice] = "Successfully followed"
        @following.count_followers
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    @following = User.find(params[:id])
    @following.count_followers
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end

end
