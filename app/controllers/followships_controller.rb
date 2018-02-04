class FollowshipsController < ApplicationController

  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
       # following_id 的  user.followers_count += 1
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: "users/tweets") # 不同 controller 的 template 的轉向方法。Action Controller-控制 HTTP 流程
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: "users/tweets")
    end
  end

  def destroy
  end
end
