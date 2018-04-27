class RepliesController < ApplicationController

  def index
    @tweet=Tweet.find(params[:id])
    @user=User.find(@tweet.user_id)
    @replies=@tweet.replies.order("updated_at DESC")    
    @reply=Reply.new
  end

  def create
    @tweet=Tweet.find(params[:id])
    @reply=Reply.new(reply_params)
    @reply.user=current_user
    @reply.tweet=@tweet
    if @reply.save
      flash[:notice] = "留言成功"

      @tweet_rp_up=Tweet.update(@tweet.id,replies_count: @tweet.replies.count)
      @tweet_rp_up.save

      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] =@reply.errors.full_messages.each{|msg| msg.class}

      render :index
    end      
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
