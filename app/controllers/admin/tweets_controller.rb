class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def destroy
  end
end
