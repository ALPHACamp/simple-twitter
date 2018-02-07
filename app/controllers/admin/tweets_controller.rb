class Admin::TweetsController < Admin::BaseController



    def index
      @tweets = Tweet.page(params[:page]).per(30).order(created_at: :desc)

    
    end

    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        redirect_to admin_tweets_path
        flash[:alert] = "tweet was deleted"
    end



  private

    def tweet_params
      params.require(:tweet).permit(:name, :description, :avatar)
    end



end
