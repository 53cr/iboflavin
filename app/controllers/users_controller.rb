class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @from_twitter = session[:use_twitter]
    session[:use_twitter] = false
    if @from_twitter and !User.find_by_login(session[:twitter_screen_name])
      @ok_to_use_screen_name = true
    end
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
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
      redirect_back_or_default new_entry_url
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
    if @user and @user.update_attributes(params[:user])
      flash[:notice] = "Changes successful!"
      redirect_back_or_default account_url
    else
      render :action => :edit
    end
  end

  def disable_sidebar_prompt
    @user = @current_user
    if @user
      @user.update_attributes( :sidebar_prompt_off => true )
      flash[:notice] = "Sorry about that. We'll leave you alone."
    end
    redirect_to new_entry_path
  end
end
