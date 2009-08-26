class Admin::UsersController < AdminController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { render :csv => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create

    @user = User.create(params[:user])

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to([:admin,@user]) 
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to([:admin,@user])
    else
      render :action => "edit" 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = "User @user was removed"
    redirect_to(admin_users_url)
  end
end
