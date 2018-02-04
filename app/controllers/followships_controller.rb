class FollowshipsController < ApplicationController
	def create
    @followship = current_user.followships.new(following_id: params[:following_id])
    @be_followed = User.find(params[:following_id])
    @be_followed.followers_count!
    if @followship.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    @be_followed = User.find(params[:id])
    @be_followed.followers_count!
    redirect_back(fallback_location: root_path)
  end
end
