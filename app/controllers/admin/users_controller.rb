class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @users = User.all.order("tweets_count DESC")
  end

end
