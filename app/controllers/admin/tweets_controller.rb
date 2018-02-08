class Admin::TweetsController < Admin::BaseController
  def index
  	@tweets=Tweet.all.order(created_at: :desc)
  end

  def show
  	@tweet=Tweet.find(params[:id])
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      flash[:notice] = "刪除成功"
      redirect_back(fallback_location: admin_root_path)
    else
      flash.now[:alert] = "刪除失敗"
      render :index
    end
  end

  def delete_reply
  	@reply = Reply.find(params[:id])
    if @reply.destroy
      flash[:notice] = "刪除成功"
      redirect_back(fallback_location: admin_root_path)
    else
      flash.now[:alert] = "刪除失敗"
      render :show
    end
  end
end
