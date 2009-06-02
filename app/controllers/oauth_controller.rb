class OauthController < ApplicationController

  def login
    @request_token = UserSession.consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    authenticate_url = @request_token.authorize_url.sub('/oauth/authorize','/oauth/authenticate')
    redirect_to authenticate_url
    return
  end

  def callback
    @request_token = OAuth::RequestToken.new(UserSession.consumer,
                                             session[:request_token],
                                             session[:request_token_secret])
    @access_token = @request_token.get_access_token
    @response = UserSession.consumer.request(:get,
                                             '/account/verify_credentials.json',
                                             @access_token,
                                             {:scheme => :query_string})
    case @response
      when Net::HTTPSuccess
        user_info = JSON.parse(@response.body)
        unless user_info['screen_name']
          flash[:notice] = "Authentication failed"
          redirect_to :action => :index
          return
        end
        # We have an authorized user
        @user = User.find_by_access_token(@access_token.token)
        if @user
          flash[:notice] = "We would have logged you in, but this hasn't been implemented yet!"
          # log user in
        else
          session[:twitter_screen_name] = user_info['screen_name']
          session[:twitter_token]       = @access_token.token
          session[:twitter_secret]      = @access_token.secret

          flash[:notice] = "Success! We just need a bit more information."
          redirect_to new_user_url
        end
      else
        RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
        # The user might have rejected this application. Or there was some other error during the request.
        flash[:notice] = "Authentication failed"
        redirect_to :action => :index
        return
    end
  end
end