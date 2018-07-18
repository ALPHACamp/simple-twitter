class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id:params[:following_id])
    @followship.save

    @user = User.new
    @user.followings_count
    @user.followers_count

    puts @user.count_followings

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id:params[:id])
    @followship.destroy_all
    redirect_back(fallback_location: root_path)
  end
end
