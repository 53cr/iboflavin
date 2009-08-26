class PasswordsController < DashboardController
  skip_before_filter       :require_user, :only => [:new,:create,:reset]
  
  filter_parameter_logging :password, 
                           :password_confirmation
  
  def new
    render :action => :new, :layout => 'application'
  end
  
  def show
    @user = current_user
    render :action => :edit
  end
  
  def create
    @user = User.find_by_email params[:password][:email]
    if @user.nil?
      flash.now[:error] = 'Unknown email'
      render :action => :new, :layout => 'application'
    else
      flash[:success] = 'Password recovery email sent.'
      UserMailer.deliver_forgotten_password @user
      redirect_to login_url
    end
  end
  
  def edit
    @user = current_user
  end

  def reset
    @user = User.find_by_perishable_token(params[:perishable_token])
    if @user.present?
      flash[:success] = 'You may now reset your password.' #Maybe more verbose here?
      UserSession.create(@user, true) 
      render :action => :edit
    else
      flash[:error] = 'Invalid password reset token.'
      render :action => :new
    end
  end
  
  def update
    params_user = params[:user]

    if params_user[:password].blank? 
      current_user.errors.add(:password, "password field is required" )    
    end

    if params_user[:password_confirmation].blank? 
      current_user.errors.add(:password_confirmation, "password confirmation field is required" )    
    end

    if not current_user.errors.any? and current_user.update_attributes(params[:user])
      flash[:success] = 'Password updated.'
      redirect_to dashboard_url
    else
      @user = current_user
      flash[:error] = 'Update failed.'
      render :action => :edit
    end
  end
end
