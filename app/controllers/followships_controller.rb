class FollowshipsController < ApplicationController
	def create
    @followship = current_user.followships.new(following_id: params[:following_id])
    @be_followed = User.find(params[:following_id])
    @followship.save
    redirect_back(fallback_location: tweets_path)
  end
  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    @be_followed = User.find(params[:id])
    redirect_back(fallback_location: tweets_path)
  end
end
