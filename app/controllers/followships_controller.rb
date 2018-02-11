class FollowshipsController < ApplicationController
  def create
    #raise "foo"
    @followship = current_user.followships.build(following_id: params[:following_id])
    @user = User.find(params[:following_id])
    @user.followers_count = @user.followers_count + 1 
    if current_user.id == :following_id
      return
    end

    if @followship.save
      @user.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @user = User.find(params[:id])
    @user.followers_count = @user.followers_count - 1 
    @followship.destroy
    @user.save
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
