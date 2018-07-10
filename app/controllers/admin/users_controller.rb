class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    #@users=User.order(tweets_count: :desc)
    @users=User.all
    @user=current_user
  end
end
