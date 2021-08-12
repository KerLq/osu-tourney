class UsersController < ApplicationController
    before_action :authorized, only: [:index, :show]

    def index

    end
    def show
        @user = current_user
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path
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
