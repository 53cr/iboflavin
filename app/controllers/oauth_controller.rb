class OauthController < ApplicationController
  def authorize
    redirect_to session[:oauth_redirect].merge(:oauth_token => params[:oauth_token])
  end
end