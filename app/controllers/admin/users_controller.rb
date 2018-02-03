class Admin::UsersController < Admin::BaseController

    # before_action :set_user
    before_action :check_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!

    def index
      @user = User.all
    end

    def update
      @user.update(user_params)
      if @user.save
        redirect_to user_path(@user)
      else
        render 'new'
      end
    end

    def destroy
    end







  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :about, :avatar)

    end

    def check_user
      if @user != current_user
        redirect_to root_path
      end
    end


    # def set_user
    #    @user = User.find(params[:id])
    # end









end
