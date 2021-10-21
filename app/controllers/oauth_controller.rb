class OauthController < ApplicationController
    def initialize
        @oauth_client = OAuth2::Client.new(Rails.configuration.x.oauth.client_id,
            Rails.configuration.x.oauth.client_secret,
            authorize_url: '/oauth/authorize',
            site: Rails.configuration.x.oauth.idp_url,
            token_url: '/oauth/token',
            redirect_uri: Rails.configuration.x.oauth.redirect_uri)
    end

 # The OAuth callback
 def oauth_callback
    # Make a call to exchange the authorization_code for an access_token
    @@callout = @oauth_client.auth_code.get_token(params[:code])
    # Extract the access token from the response
    #debugger
    @token = @@callout.to_hash[:access_token]
    player = @@callout.get('api/v2/me/osu', :params => { 'Authorization' => 'Bearer ' + @token })
    player = player.parsed
    
    # Set the token on the user session
    session[:user_jwt] = {value: player, httponly: true}

    redirect_to root_path
  end

  def logout
    # Invalidate session with FusionAuth
    #debugger
    # @oauth_client.request(:get, 'oauth/logout')
    # # Reset Rails session
        
    #@oauth_client.request(:delete, 'api/v2/oauth/tokens/current')
    session.destroy(:user_jwt)

    redirect_to root_path
  end

  def login
    redirect_to @oauth_client.auth_code.authorize_url
  end
end