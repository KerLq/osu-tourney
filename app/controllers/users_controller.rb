class UsersController < ApplicationController
    before_action :authorized, only: [:index, :show] # :edit, :destroy, :delete etc
    def register
        @user = User.new
    end
    def show
        @user = current_user
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
