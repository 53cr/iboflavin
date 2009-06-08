require File.join(File.dirname(__FILE__), "/../../spec_helper")
require 'nutrition'

describe Nutrition::EnergyRequirement do
  it { Nutrition::EnergyRequirement.should respond_to :for }
  it "should provide correct kcal requirements for lifestyle" do
    @user = mock("User")
    @user.stub(:age).and_return(22)
    @user.stub(:male?).and_return(true)
    @user.stub(:sex).and_return(:male)
    
    { :sedentary => 2500, :low_active =>	2700, :active => 3000, :nil => 2700 }.each do |lifestyle,kcals|
      @user.stub(:lifestyle).and_return(lifestyle)
      Nutrition::EnergyRequirement.for(@user).should be kcals
    end
  end
  it "should provide 2000 if the user doesn't have any details" do
    @user = mock("User")
    @user.stub(:sex).and_return(nil)
    Nutrition::EnergyRequirement.for(@user).should be 2000
  end
end