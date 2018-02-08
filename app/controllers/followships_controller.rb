class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      @following_user = User.find(@followship.following_id)
      @following_user.count_followers
      #flash[:notice] = "user was be successfully followed"
    else
      #flash[:alert] = @followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @following_user = User.find(@followship.following_id)
    @followship.destroy
    @following_user.count_followers

    #flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
