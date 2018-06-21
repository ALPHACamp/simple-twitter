class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = @tweet.replies
    @user = @tweet.user
    @tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
    @likes = @user.likes
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.create(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice]="成功留言"
      redirect_to tweet_replies_path(@tweet)
    else
      flash[:alert]="留言失敗，請填入內容"
      redirect_to tweet_replies_path(@tweet)
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:comment)
  end

end
