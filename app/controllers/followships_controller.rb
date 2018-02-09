class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      flash[:alert] = "成功追蹤#{User.find_by(id: params[:following_id]).name}！"
      redirect_back(fallback_location: tweets_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: tweets_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "取消追蹤#{User.find_by(id: params[:id]).name}！"
    redirect_back(fallback_location: tweets_path)
  end
end
