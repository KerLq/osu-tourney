class Frontend::OauthController < Frontend::FrontendController
  def initialize
    #@oauth_client = OAuth2::Client.new(
    #debugger
    #Osu::Oauth::OsuOauth.new
    # @oauth_client = OAuth2::Client.new(
    #   Rails.configuration.x.oauth.client_id,
    #   Rails.configuration.x.oauth.client_secret,
    #   authorize_url: '/oauth/authorize?scope=public',
    #   site: Rails.configuration.x.oauth.idp_url,
    #   token_url: '/oauth/token', # Check again
    #   redirect_uri: Rails.configuration.x.oauth.redirect_uri,
    # )
    
    @@osuOAuth = Osu::Api::OAuth.new(
      Rails.configuration.x.oauth.client_id,
      Rails.configuration.x.oauth.client_secret,
      Rails.configuration.x.oauth.redirect_uri
    )
    
  end
  
  # The OAuth callback
  def oauth_callback
    # Make a call to exchange the authorization_code for an access_token
    #setOsuApi(@osuApi)
    #cookies[:api] = @osuApi
    #@@callout = @oauth_client.auth_code.get_token(params[:code])
    @@osuOAuth.setToken(params[:code])
    #@oauth_client.setAccessToken
    
    #@oauth_client.
    # Extract the access token from the response
    #debugger
    #@token = @@callout.to_hash[:access_token]
    
    #player = @@callout.get('api/v2/me/osu')
    player = @@osuOAuth.getOwnData
    #debugger
    #player = player.parsed
    
    if player['id'].nil?
      flash[:error] = "Login failed!"
      redirect_to root_path
    end
    user = User.create_from_oauth(player)

    session[:user_id] = user.id
    session[:access_token] = @@osuOAuth.getAccessToken
    #set_access_token(@token)
    redirect_to frontend_root_path # last visited page
  end

  def logout
    # Invalidate session with FusionAuth
    #debugger
    # @oauth_client.request(:get, 'oauth/logout')
    # # Reset Rails session
        
    #@oauth_client.request(:delete, 'api/v2/oauth/tokens/current')
    reset_session

    redirect_to frontend_root_path
  end

  def login
    redirect_to @@osuOAuth.auth_code.authorize_url
  end
end