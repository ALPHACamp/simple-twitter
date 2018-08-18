class RepliesController < ApplicationController

  before_action :set_tweet, only: [:index, :create]

  def index
    # 將 reply 最新的留言保持在最上面
    @replies = @tweet.replies.order(created_at: :desc)
    @reply = Reply.new
  end

  def create
    # 由於 『一則 tweet 有很多 reply』，透過 @tweet.replies.build
    # 來建立新的 reply 物件，新的物件會帶入 tweet_id
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def set_tweet
    # 因為是用 nested resources 所以是用 :tweet_id 而不是 :id
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
