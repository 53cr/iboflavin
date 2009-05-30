class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def self.consumer
    OAuth::Consumer.new(TWITTER_LOGIN_CONSUMER_TOKEN,
                        TWITTER_LOGIN_CONSUMER_SECRET,
                        { :site => 'http://twitter.com'})
  end

  def create_from_twitter
    @request_token = UsersController.consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    redirect_to @request_token.authorize_url
    return
  end

  def callback
    @request_token = OAuth::RequestToken.new(UsersController.consumer,
                                             session[:request_token],
                                             session[:request_token_secret])
    @access_token = @request_token.get_access_token
    @response = UsersController.consumer.request(:get,
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
      # We have an authorized user, save the information to the database.
      @user = User.new()
      @user.twitter_screen_name = user_info['screen_name']
      @user.twitter_token = @access_token.token
      @user.twitter_secret = @access_token.secret

      @user.save(false)
      @user.reload
      redirect_to( @user )
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      # The user might have rejected this application. Or there was some other error during the request.
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
    end
  end
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

end
