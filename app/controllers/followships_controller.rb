class FollowshipsController < ApplicationController
  def create
    @followship = Followship.new(user_id: current_user.id, following_id: params[:following_id])
    if @followship.save
      current_user.followers_count = current_user.followers.size
      current_user.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert]= @followship.errors.full_messages.to_sentence
    end

  end

  def destroy
    @followship = current_user.followships.where(params[:following_id]).first
    @followship.destroy
    current_user.followers_count = current_user.followers.size
    current_user.save
    redirect_back(fallback_location: root_path)
  end


  private
  def followship_params
    params.require(:followship).permit(:user_id, :following_id)

  end
end
