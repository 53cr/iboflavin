class Dashboard::InfosController < DashboardController
  before_filter :load_user

  def show
  end

  def edit
  end

  def update
    user_params = params[:user]
    user_params.delete(:admin) unless user_params.blank?

    if @user.update_attributes(user_params)
      flash[:success] = 'Users was successfully updated.'
      redirect_to( dashboard_info_url) 
    else
      render :action => :edit
    end
  end

  private
  def load_user
    @user = current_user
  end
end
