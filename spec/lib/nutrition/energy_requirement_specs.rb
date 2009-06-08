require File.join(File.dirname(__FILE__), "/../spec_helper")
require 'nutrition'

describe Nutrition::EnergyRequirement do
  it { should respond_to :for }
  it "should provide correct kcal requirements for lifestyle" do
    @user = mock("User")
    @user.stub(:age, 22)
    @user.stub(:sex, :male)
    
    { :sedentary => 2500, :low_active =>	2700, :active => 3000, :nil => 2700 }.each do |lifestyle,kcals|
      @user.stub(:lifestyle, lifestyle)
      Nutrition::EnergyRequirement.for(@user).should be kcals
    end
  end
end