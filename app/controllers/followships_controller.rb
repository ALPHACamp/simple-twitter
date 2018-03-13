class FollowshipsController < ApplicationController
  
  #產生一個新物件
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      @user = User.find(@followship.following_id)
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @user = User.find(@followship.following_id)
    @followship.destroy
    flash[:alert] = "Unfollowed"
    redirect_back(fallback_location: root_path)
  end
end
