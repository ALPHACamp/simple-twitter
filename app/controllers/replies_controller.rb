class RepliesController < ApplicationController

  def index
    @tweet_id = :id
    @user = User.find(@tweet.user.id)
    @tweet = Tweet.where(@tweet_id)
    @replies = @tweet.comment
  end

  def create
    @tweet = Tweet.find(:id)
    @user = User.find(current_user.id)
    @replies = @tweet.comment.build(replie_params)
    @replies.user = current_user
    @replies.save!
    redirect_back(fallback_location: root_path)
  end

  def replie_params
    params.require(:replies).permit(:comment)
  end
end
