class FollowshipsController < ApplicationController

  def create
    if @followship != current_user
     @followship = current_user.followships.build(following_id: params[:following_id])

     if @followship.save
       flash[:notice] = "Successfully followed"
       redirect_back(fallback_location: root_path)
     else
       flash[:alert] = @followship.errors.full_messages.to_sentence
       redirect_back(fallback_location: root_path)
     end
    end
  end

    def destroy
      @followship = current_user.followships.where(following_id: params[:id]).first
      @followship.destroy
      flash[:alert] = "Unfollwed successfully"
      redirect_back(fallback_location: root_path)
    end


    # def followship_count
    #   followship_count = self.followings.conut
    # end

end
