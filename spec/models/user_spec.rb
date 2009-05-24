require File.join(File.dirname(__FILE__), "/../spec_helper")

describe "A User" do
  before(:each) do
    @user = User.new
  end
  it "cannot be older than 999" do
    pending
    @user.age = 1000
    @user.should be_invalid
  end
end
