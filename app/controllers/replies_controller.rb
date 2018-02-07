class RepliesController < ApplicationController

  def index
     @tweet= Tweet.find(params[:id])
     @reply = Reply.new
     @reply_all = Reply.order(created_at: :desc).limit(10)
  end

  def create
     @tweet= Tweet.find(params[:id])
     @replies = @tweet.replies.build(replies_params)
     @replies.user = current_user
    if @replies.save
      redirect_to replies_path(Tweet.find(params[:id]))
   end
  end

  def like
    @tweet_id = Tweet.find(params[:id])
    @tweet_id.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unlike
    @tweet_id = Tweet.find(params[:id])
    likesx = Like.where(tweet: @tweet_id , user: current_user)
    likesx.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
def replies_params
  params.require(:reply).permit(:comment)
end
end
