class RepliesController < ApplicationController

  def index
    @replies = @tweet.replies
    @user = current_user
    @reply = Reply.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @user = current_user
    @reply = current_user.replies.build(reply_params)

    if @reply.save
      flash[:notice] = "Reply was successfully created"
    else
      flash[:alert] = "Reply was failed to create"
    end
    redirect_back(fallback_location: root_path)
  end


  private
    def reply_params
      params.require(:tweet).permit(:comment, :user_id, :tweet_id, :created_at, :updated_at)
    end

end
