class Admin::UsersController < Admin::BaseController

  


    def index
      @users = User.page(params[:page]).per(30).order("tweets_count DESC")

    end


end
