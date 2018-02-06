class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.create(following_id: params[:id])
  end

  def destroy
  end
end
