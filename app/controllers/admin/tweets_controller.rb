class Admin::TweetsController < Admin::BaseController
  def index
    @recent_tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    @recent_tweet.destroy 

    if @recent_tweet.error.any?
      flash[:alert] = @recent_tweet.errors.full_messages.to_sentense
    else
      flash[:notice] = "tweet was successfully deleted!!!"
    end
    
  redirect_to admin_tweets_path      
  end
end
