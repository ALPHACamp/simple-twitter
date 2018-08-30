class FollowshipsController < ApplicationController
  def create
  	@followship = Followship.new(user_id: current_user.id, following_id: params[:following_id])
  	if @followship.user_id == @followship.following_id
      flash[:alert] = "Something went wrong here...you can not follow yourself..."
  	else
  		@followship.save
  	end
    redirect_back(fallback_location: root_path)
  end

  def destroy
  	@followship = Followship.find_by(user_id: current_user.id, following_id: params[:id])
  	if @followship
  		@followship.destroy
  	else
  		flash[:alert] = "Something went wrong here...please try again"
  	end
  	redirect_back(fallback_location: root_path)
  end
end
