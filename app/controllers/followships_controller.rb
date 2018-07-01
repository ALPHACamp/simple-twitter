class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    if @user == current_user
      flash[:alert] = "Can't follow yourself!"
      redirect_to tweets_path
    else
      @followship = current_user.followships.new(following_id:params[:following_id])
      if @followship.save
        flash[:notice] = "You are following him/her now!"
        redirect_to tweets_path
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: tweets_path)
      end
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:alert] = "Followship deleted."
    redirect_back(fallback_location: tweets_path)
  end
end
