class FollowshipsController < ApplicationController
  before_action :followship_params ,only: [:create]
  before_action :set_followship ,only: [:destroy]
  
  def create
    @followship = current_user.followships.build(followship_params)
    if @followship.save
      flash[:notice] = 'Successfully followed!'
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @followship.destroy
    flash[:alert] = 'Unfollowed!'
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
