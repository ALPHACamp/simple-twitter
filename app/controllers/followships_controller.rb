class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    if current_user != @user
      @followship = current_user.followships.build(following_id: params[:following_id])
      if @followship.save
        @user.count_follower
        flash[:notice] = "Successfully follow"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    @user = User.find(params[:following_id])
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    @user.count_follower
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
