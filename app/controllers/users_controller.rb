class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @from_twitter = session[:use_twitter]
    session[:use_twitter] = false
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = "Login successful!"
        redirect_back_or_default account_url
      else
        render :action => :new
      end
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
    @user.save do |result|
      if result
        flash[:notice] = "Login successful!"
        redirect_back_or_default account_url
      else
        render :action => :new
      end
    end
  end

end
