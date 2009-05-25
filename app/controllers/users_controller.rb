class UsersController < ApplicationController

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
      @user = User.new({ :twitter_screen_name => user_info['screen_name'],
                         :twitter_token => @access_token.token,
                         :twitter_secret => @access_token.secret })

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
  

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
