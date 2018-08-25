class FollowshipsController < ApplicationController
  def create
    # 產生一個新的 Followship 物件，並設定兩個外鍵 user_id 和 following_id
    @followship = current_user.followships.build(following_id: params[:following_id])
    # 將攜帶資料的 Followship 物件存入資料庫
    if @followship.save
      # 如果成功儲存到資料庫裡，則導回同一頁，並顯示成功訊息
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      # 如果驗證失敗，也導回同一頁，並將錯誤訊息顯示給使用者
      flash[:alart] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # 在 followships table 上查詢出一筆資料，其外鍵符合 current_user 與前端傳進來的 params[:id]
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:alart] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
  
end
