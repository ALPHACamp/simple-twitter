class FollowshipsController < ApplicationController
before_action :get_following_user, only: [:create, :destroy]
#after_action :update_followers_count, only: [:create, :destroy]

  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if User.find(params[:following_id]) == current_user
      flash[:alert] = "can't follow yourself"
    else
      if @followship.save
        @following_user.followers_count = @following_user.followers.count
        @following_user.save
        flash[:alert] = "Successfully followed"
      else
        flash[:alert] = @followship.errors.full_messages.to_sentence
      end
    end
    redirect_back(fallback_location: user_path(@following_user))
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:following_id]).first
    @followship.destroy
    @following_user.followers_count = @following_user.followers.count
    @following_user.save
    flash[:alert] = "Followship destroyed"
    redirect_to followings_user_path(current_user)
  end

  private

    def get_following_user
      @following_user = User.find_by_id(params[:following_id])
    end

    def update_followers_count   #暫時未使用     
      @following_user.followers_count = @following_user.followers.count
      if @following_user.save
      flash[:notice] = "save"
      else
      flash[:notice] = "dont save"
      end
      redirect_back(fallback_location: user_path(@following_user))      #啟用的話會出現redirect multiple times
    end

end
