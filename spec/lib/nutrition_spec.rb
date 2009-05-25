require File.join(File.dirname(__FILE__), "/../spec_helper")
require 'nutrition'

module Nutrition
  describe "Nutrition" do
    it "should provide access to raw data" do
      lambda { Nutrition.raw_data }.should_not raise_error
    end
    context "should return values for" do
      it "all ages from 0 months to 999 years"
      it "both sexes"
      it "infants"
      it "children"
      it "lactating women"
      it "pregnant women"
    end
  end
end