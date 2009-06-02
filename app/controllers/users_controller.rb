class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @from_twitter = session[:use_twitter]
    session[:use_twitter] = false
    if @from_twitter and !User.find_by_login(session[:twitter_screen_name])
      @ok_to_use_screen_name = true
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if params[:user][:link_twitter]
      @user.twitter_screen_name = session[:twitter_screen_name]
      @user.oauth_token = session[:twitter_token]
      @user.oauth_secret = session[:twitter_secret]
    end
    
    if @user.save
      flash[:notice] = "Login successful!"
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
    if @user.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
end
