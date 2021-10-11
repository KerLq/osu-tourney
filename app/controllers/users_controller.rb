class UsersController < ApplicationController
  include UsersHelper
    #before_action :authorized, only: [:index, :show] # :edit, :destroy, :delete etc

    after_action :save_my_previous_url

    def save_my_previous_url
      # session[:previous_url] is a Rails built-in variable to save last url.
      session[:my_previous_url] = request.fullpath
    end


    def register
        @user = User.new
    end
    def show
        @user = User.find_by(id: params[:id])
        if !@user
          redirect_to session[:my_previous_url]
        end
    end
    def index

    end
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to login_path
        else

        end
    end

    private
    def user_params
        params.require(:user).permit(
            :username,
            :email,
            :password
        )
    end
end
