class Backend::BackendController < ApplicationController
    before_action :permission?
    layout 'backend'
    def permission?
        if !is_admin? 
            redirect_to frontend_root_path
        end
        # post_admin_log
    end


    def post_admin_log
        
        current_user.sendDiscordNotification(current_user, frontend_user_path(current_user))
    end
end