class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    @user = User.find(params[:following_id])
    @user.followers_count = @user.followers.count
    if current_user != @user
      if @followship.save
        @user.save
        flash[:notice] = "Follow success"
      
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "you can't follow yourself"
    end
  end

  def destroy
    @followship =current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    @user = User.find(params[:id])
    @user.followers_count = @user.followers.count
    @user.save
    flash[:alert] = "We are not friend anymore"
    redirect_back(fallback_location: root_path)

  end

  def count_params
    params.require(:user).permit(:followers_count)
  end

end
