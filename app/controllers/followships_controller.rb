class FollowshipsController < ApplicationController
  def create
      @followship = current_user.followships.build(following_id: params[:following_id])
      #following_user = User.where(id: params[:following_id])
    if @followship.save
      #flash 會留到下一個request
      flash[:notice] = "followship was scuccessfully created"
      #current_user.count_followers(following_user)
      redirect_back(fallback_location: root_path)
    else
      #flash.now 只存在現在這個request
      flash[:alert] = @followship.errors.full_messages.to_sentence
      
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    #following_user = User.where(id: params[:following_id])
    #@followship = current_user.followships.where(following_id: params[:id])
    #回傳維陣列,所以使用destroy_all刪除
    @followship.destroy
    flash[:alert] = "followship destroyed"
    # current_user.count_followers(following_user)
    redirect_back(fallback_location: root_path)
  end
end
