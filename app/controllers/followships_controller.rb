class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    if current_user != @user
      @followship = current_user.followships.build(following_id: params[:following_id])
      if @followship.save      
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "You can't follow yourself!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = Followship.where(user: current_user, following_id: params[:id]).first
    @followship.destroy
    redirect_back(fallback_location: root_path)
  end
end
