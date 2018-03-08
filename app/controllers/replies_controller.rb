class RepliesController < ApplicationController

  def index
    # 找出要回覆的推文
    @tweet = Tweet.find(params[:tweet_id])

    # 找出該推文的作者
    @user = User.find(@tweet.user_id)

    # 讓使用者輸入回覆
    @reply = Reply.new

    # 如果這個推文有 reply
    @replies = @tweet.replies
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])

    @reply = Reply.create!(user_id: current_user.id, tweet_id: params[:tweet_id], comment: reply_params[:comment])

    # 已有 tweet_id 與
    # @reply = @tweet.replies.build(reply_params)
    # 還缺 user_id
    # @reply.user_id = current_user.id

    # 從 current_user 關聯過去的 reply build 不會自動帶入 reply_params 裡的 tweet_id ? 所以這種關聯方法會帶入的是 source 的 id 囉
    # @reply = current_user.replies.build(reply_params)
    # @reply.tweet_id = @tweet.id

    # @reply.save!
    redirect_to tweet_replies_path(@tweet.id)
  end

  private
  def reply_params
    params.require(:reply).permit(:comment)
  end

end
