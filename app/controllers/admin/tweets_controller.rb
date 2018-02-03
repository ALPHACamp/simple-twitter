class Admin::TweetsController < Admin::BaseController

  before_action :set_tweet, only:  [:show, :destroy]

    def index
      # @tweets = Tweet.page(params[:page]).per(30)
        @tweets = Tweet.all

        
    end

    def destroy
        @tweet.destroy
        redirect_to admin_tweets_path
        flash[:alert] = "tweet was deleted"
    end



  private

    def tweet_params
      params.require(:tweet).permit(:user_name, :description, :avatar)
    end

    def set_tweet
       @tweet = Tweet.find(params[:id])
    end




end
