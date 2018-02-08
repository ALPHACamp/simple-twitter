class FollowshipsController < ApplicationController
  
  def create
    if User.find(params[:following_id]) == current_user
      flash[:alert] = "不能follow自己！"
      redirect_back(fallback_location: tweets_path)
    else
      @followship = current_user.followships.build(following_id: params[:following_id])
      if @followship.save
        # 計算follower_count
        @following_user = User.find(params[:following_id])
        @following_user.followers_count = @following_user.followers.size
        @following_user.save
        flash[:notice] = "已成功Follow該使用者"
        redirect_back(fallback_location: tweets_path)
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
        redirect_back(fallback_location: tweets_path)
      end
    end

  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    @following_user = User.find(params[:id])
    @following_user.followers_count = @following_user.followers.size
    @following_user.save
    flash[:notice] = "已成功Unfollow該使用者"
    redirect_back(fallback_location: tweets_path)
  end
end
