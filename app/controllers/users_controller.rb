class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new,:confirm,:create]
  
  def index
    @teams = User.teams
  end

  def new
    @user = User.new(params[:user])
  end
  
  def confirm
    @user = User.find_by_perishable_token(params[:perishable_token])
    if @user
      @user.confirm!
      UserSession.create(@user,true)
      flash[:success] = 'Successfully confirmed.'
      redirect_to dashboard_url
    else
      flash[:error] = 'Invalid user.'
      redirect_to signup_url
    end
  end  
  
  def create
    user_params = params[:user]
    user_params.delete(:admin) unless user_params.blank?

    @user = User.new params[:user]
    if @user.save
      flash[:success] = "You will receive an email within the next few minutes. It contains instructions for you to confirm your account."
      redirect_to login_url
    else
      flash[:error] = "User failed to be created"
      render :action => "new"
    end
  end
end
