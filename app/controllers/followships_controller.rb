class FollowshipsController < ApplicationController
  def create
    user = User.find_by_id(params[:following_id])
    
    if current_user == user
      flash[:alert] = "You can not follow yourself."
    else
      @followship = current_user.followships.build(following_id: params[:following_id])
      @followship.save

      # user.count_followers  rspec創造Followship的方式未經過此create method，故不會重新計算follower。而count_cache在model設定中所以會重新計算。
    end     
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followships = Followship.where(user: current_user, following: params[:id])
    @followships.destroy_all

    user = User.find(params[:id])
    # user.count_followers   rspec創造Followship的方式未經過此create method，故不會重新計算follower。而count_cache在model設定中所以會重新計算。
    redirect_back(fallback_location: root_path)
  end
end
