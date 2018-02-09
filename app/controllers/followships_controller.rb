class FollowshipsController < ApplicationController
  def create
    @user_id = User.find(params[:following_id])
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      Followship.count = 0
        # @user_id.followers_count = @user_id.followers.count
        flash[:notice] = "Successfully followed"
        redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    @user_id = User.find(params[:id])
    @user_id.followers_count = @user_id.followers.count
    @user_id.save
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
