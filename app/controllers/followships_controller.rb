class FollowshipsController < ApplicationController

  before_action :followship_params ,only: [:create]
  before_action :set_followship ,only: [:destroy]

  def create
    if @followship != current_user
     @followship = current_user.followships.build(following_id: params[:following_id])

    end

    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end




    def destroy
      @followship = current_user.followships.where(following_id: params[:id]).first
      @followship.destroy
      flash[:alert] = "Unfollwed successfully"
      redirect_back(fallback_location: root_path)
    end


    
    private

    def followship_params
      params.permit(:following_id)
    end

    def set_followship
      @followship = current_user.followships.find_by(following_id: params[:id])
    end


end
