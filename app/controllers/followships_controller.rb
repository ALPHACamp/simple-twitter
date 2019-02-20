class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    unless @user == current_user
      @followship = current_user.followships.build(following_id: params[:following_id])
      
      if @followship.save
        flash[:notice] = "Successfully followed #{@followship.following.name}"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:notice] = "You can't follow yourself."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed with #{@followship.following.name}"
    redirect_back(fallback_location: root_path)
  end
end
