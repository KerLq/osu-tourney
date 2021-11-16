class OauthController < ApplicationController
    def initialize
        @oauth_client = OAuth2::Client.new(
            Rails.configuration.x.oauth.client_id,
            Rails.configuration.x.oauth.client_secret,
            authorize_url: '/oauth/authorize?scope=public',
            site: Rails.configuration.x.oauth.idp_url,
            token_url: '/oauth/token', # Check again
            redirect_uri: Rails.configuration.x.oauth.redirect_uri,
        )
      end

 # The OAuth callback
 def oauth_callback
    # Make a call to exchange the authorization_code for an access_token
    @@callout = @oauth_client.auth_code.get_token(params[:code])
    # Extract the access token from the response
    #debugger
    @token = @@callout.to_hash[:access_token]
    player = @@callout.get('api/v2/me/osu', :params => { 'Authorization' => 'Bearer ' + @token })
    headers = {
      "Content-Type":"application/json",
      "Accept":"application/json",
      "Authorization":"Bearer #{@token}",
    }
    params = {
      "mode":"osu",
      "limit":5,
    }
    response = HTTParty.get("https://osu.ppy.sh/api/v2/matches/89309929",
      body: params.to_json,
      headers: headers
  )

  player = player.parsed
    if player['id'].nil?
      flash[:error] = "Login failed!"
      redirect_to root_path
    end
    response = response.parsed_response
    user = User.create_from_oauth(player)

    session[:user_id] = user.id

    redirect_to root_path # last visited page
  end

  def logout
    # Invalidate session with FusionAuth
    #debugger
    # @oauth_client.request(:get, 'oauth/logout')
    # # Reset Rails session
        
    #@oauth_client.request(:delete, 'api/v2/oauth/tokens/current')
    reset_session

    redirect_to root_path
  end

  def login
    redirect_to @oauth_client.auth_code.authorize_url
  end
end