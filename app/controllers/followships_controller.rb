class FollowshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    if @user == current_user
      flash[:notice] = "Can't follow self!"
      redirect_to tweets_path
    else
      @followship = Followship.create(user_id:current_user.id, following_id:params[:following_id])
      if @followship.save
        flash[:notice]="Successfully followed"
        redirect_back(fallback_location: tweets_path)
      else
        flash[:alert]=@followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: tweets_path)
      end
    end
  end

  def destroy
    @followship = Followship.where(user_id:current_user.id, following_id:params[:id]).first
    @followship.destroy
    flash[:alert]="Followship destroyed"
    redirect_back(fallback_location: tweets_path)
  end
end  
 