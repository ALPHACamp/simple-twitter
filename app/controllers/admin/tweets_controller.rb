class Admin::TweetsController < Admin::BaseController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  def index
  	@tweets = Tweet.page(params[:page]).per(10)
  end
  def new
  	@tweet = Tweet.new
  end
  def create
  	@tweet = Tweet.new(tweet_params)
  	if @restaurant.save
  		flash[:notice] = "tweet is successfully create"
  		redirect_to admin_tweets_path
  	else
  		flash.now[:alert] = "tweet is failed to create"
  		render :new
  	end
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
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "tweet was deleted"
  end

  private
  def tweet_params
  	params.require(:tweet).permit(:name, :opening_hours, :tel ,:address, :description, :image, :category_id, :remote_image_url)
  end
  def set_tweet
  	@tweet = tweet.find(params[:id])
  end
end
