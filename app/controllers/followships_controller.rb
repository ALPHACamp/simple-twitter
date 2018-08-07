class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    if @user == current_user
      flash[:notice] = "Can't follow self!"
      redirect_back(fallback_location: root_path)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])

      if @followship.save
        flash[:notice] = "Successfully followed"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    end
  end
  def destroy
    @followship = current_user.followships.where(following_id:params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
    #複數寫法
    # @followship = current_user.followships.where(following_id: params[:id])
    # @followship.destroy_all
  end
end
