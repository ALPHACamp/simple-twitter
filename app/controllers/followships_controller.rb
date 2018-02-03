class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      redirect_back fallback_location: root_path, notice: "follow success"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentences
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "unfollowed!!"
    redirect_back fallback_location: root_path
  end
end
