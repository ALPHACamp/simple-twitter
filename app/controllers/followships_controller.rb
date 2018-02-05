class FollowshipsController < ApplicationController

  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    @user = User.find(params[:following_id])
    if @followship.save
       @user.increment!(:followers_count)
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: "users/tweets") # 不同 controller 的 template 的轉向方法。Action Controller-控制 HTTP 流程
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: "users/tweets")
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @user = User.find(params[:following_id])
    @followship.destroy
    @user.decrement!(:followers_count)
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: "users/tweets")
  end
end
