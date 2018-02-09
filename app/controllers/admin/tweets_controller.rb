class Admin::TweetsController < Admin::BaseController

  def index
    @tweets = Tweet.order(updated_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      flash[:notice] = "tweet was be successfully deleted"
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
    end
    redirect_to admin_root_path
  end
end
