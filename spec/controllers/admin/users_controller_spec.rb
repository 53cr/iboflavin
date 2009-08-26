require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do

  #Delete this example and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(Admin::UsersController)
  end

end


describe "While not logged in" do
    describe Admin::UsersController, "GET index" do

    it "should redirect to login page" do
      get :index
      response.should redirect_to login_path
    end
  end
end
describe "While an administrator" do
  before(:each) do
    activate_authlogic
    UserSession.create(Factory(:user, :admin => true)) # logs a user in
  end
  describe Admin::UsersController, "GET index" do
    it "should list all users" do
      get :index
      response.should_not redirect_to login_path
    end
  end
end
