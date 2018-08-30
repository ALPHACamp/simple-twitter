class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfilly followed"
      redirect_back(fallback_location: tweets_user_path(params[:following_id]))
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: tweets_user_path(params[:following_id]))
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: tweets_user_path(params[:id]))
  end
end
