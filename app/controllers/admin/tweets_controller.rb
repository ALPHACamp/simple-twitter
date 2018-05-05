class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @tweet = Tweet.new

    @tweets = Tweet.all.order(created_at: :desc)
    @popular_users = User.all.order(follower_count: :desc).limit(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_url
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :action => "index"
    end     
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name, :description)
  end
end
