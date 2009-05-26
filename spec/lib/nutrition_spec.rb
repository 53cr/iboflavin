require File.join(File.dirname(__FILE__), "/../spec_helper")
require 'nutrition'

module Nutrition
  describe "Nutrition" do
    it "should provide access to raw data" do
      lambda { Nutrition.raw_data }.should_not raise_error
    end
    specify { Nutrition::Requirements.should respond_to :for}
  end
end