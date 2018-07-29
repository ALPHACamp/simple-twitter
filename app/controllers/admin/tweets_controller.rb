class Admin::TweetsController < Admin::BaseController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  def index
  	@tweets = Tweet.page(params[:page]).per(10)
  end
  def create
    @user= current_user
    @tweet= @user.tweets.build(tweet_params)
    @tweet.save!
    redirect_to tweet_path(@tweet)
  end
  def show
  	
  end
  def edit
  	
  end
  def update
  	if @tweet.update(tweet_params)
  		flash[:notice] = "tweet is successfully updated"
  		redirect_to admin_tweets_path(@tweet)
  	else
  		flash.now[:alert] = "tweet was failed to update"
  	end
  end
  def destroy
    if current_user.admin?
      @tweet.destroy
      redirect_to tweets_path
    end
    flash[:alert] = "tweet was deleted"
  end

  private
  def tweet_params
  	params.require(:tweet).permit( :description)
  end
  def set_tweet
  	@tweet = Tweet.find(params[:id])
  end
end
