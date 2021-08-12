class UsersController < ApplicationController
    def index

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
