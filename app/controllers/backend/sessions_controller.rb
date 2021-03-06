class Backend::SessionsController < Backend::BackendController
    include SessionsHelper

    def login
    end
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in(user)
          redirect_to root_path
        else
          flash[:error] = "Invalid email/password combination"
          render :login
        end
    end

    def destroy
        log_out
        redirect_to root_path
    end

end
