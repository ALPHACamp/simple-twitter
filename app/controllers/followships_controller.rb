class FollowshipsController < ApplicationController
  def create
      @followship = current_user.followships.build(following_id: params[:following_id])
      
      @following_user = User.find(@followship.following_id)
    
    if @followship.save
      #flash 會留到下一個request
      flash[:notice] = "followship was scuccessfully created"
      @following_user.count_followers
      redirect_back(fallback_location: root_path)
    else
      #flash.now 只存在現在這個request
      flash[:alert] = @followship.errors.full_messages.to_sentence
      
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @following_user = User.find(@followship.following_id)
    
    #回傳維陣列,所以使用destroy_all刪除
    @followship.destroy
    @following_user.count_followers
    flash[:alert] = "followship destroyed"
    # current_user.count_followers(following_user)
    redirect_back(fallback_location: root_path)
  end
end
