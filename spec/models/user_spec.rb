require File.join(File.dirname(__FILE__), "/../spec_helper")

describe User do
  before(:each) do
    @user = User.new
  end
  
  it { should respond_to :sex }
  it { should respond_to :pregnant? }
  it { should respond_to :lactating? }
  it { should respond_to :child? }
  it { should respond_to :infant? }
  
  it "cannot be older than 999" do
    pending
    @user.age = 1000
    @user.should be_invalid
  end
end
