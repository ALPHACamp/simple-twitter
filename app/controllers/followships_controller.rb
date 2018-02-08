class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      @following = User.find(params[:following_id])
      @following.count_followers
      
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = Followship.where(user: current_user, following_id: params[:id]).first
    @followship.destroy
    
    @following = User.find(params[:id])
    @following.count_followers
    
    redirect_back(fallback_location: root_path)
  end
end
