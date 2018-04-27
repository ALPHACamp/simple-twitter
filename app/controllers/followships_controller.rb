class FollowshipsController < ApplicationController
  def create
    @follower=User.find(params[:following_id])
    @followship=current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice]="Successfully followed"

      @follower_count=@follower.followers.count
      @follower_user=User.update(@follower.id,followers_count: @follower_count)
      @follower_user.save!

      redirect_back(fallback_location: root_path)
    else
      flash[:alert]=@followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end    
  end

  def destroy
    @follower=User.find(params[:id])
    @followship=current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    # or...
    #@followship = current_user.followships.where(following_id: params[:id])
    #@followship.destroy_all

    @follower_count=@follower.followers.count
    @follower_user=User.update(@follower.id,followers_count: @follower_count)
    @follower_user.save!      
      
    flash[:alert]="Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
