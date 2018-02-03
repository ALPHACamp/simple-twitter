class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only:[:show, :edit, :update, :destroy]
  def index
    @tweets = Tweet.all
  end

  def destroy
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
end
