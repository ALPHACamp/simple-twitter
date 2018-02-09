class FollowshipsController < ApplicationController
  def new
  end
  def create
    @following = User.find(params[:following_id])

    if not @following == current_user
  	 @followship = current_user.followships.build(following_id: params[:following_id]) 
    else
      flash[:alert] = "You cannot follow yourself"
      redirect_back(fallback_location: root_path)
    end

  	if @followship.save
  		flash[:notice] = "Successfully followed"
      @following.increment!(:followers_count)
	    redirect_back(fallback_location: root_path)
  	else
  		flash[:alert] = @followship.errors.full_messages.to_sentence
	    redirect_back(fallback_location: root_path)
  	end
  end

  def destroy
    @following = User.find(params[:id])
  	@followship = current_user.followships.where(following_id: params[:id])
  	if @followship
  		@followship.destroy_all()
      @following.decrement!(:followers_count)
  		flash[:notice] = "Successfully unfollowed"
  		redirect_back(fallback_location: root_path)
  	end

  end
end
