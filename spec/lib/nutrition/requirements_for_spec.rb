require File.join(File.dirname(__FILE__), "/../../spec_helper")
require 'nutrition'

module Nutrition
  describe Requirements do
    it "can translate Nutrient model instance to Requirements key" do
      
    end
    
    # All Nutrients in Nutrition should have the same units as Nutrition
    Nutrition::Requirements::NUTRIENT_IDS_TO_NUTRIENT.each do |id, symbol|
      nutrient = Nutrient.find(id)
      it "should have the same units for #{nutrient.description}" do
        Nutrition::Requirements::UNITS[symbol].should == nutrient.unit.to_sym
      end
    end

    it "should return a value for a listed Nutrient"
    it "should return nil for an unlisted Nutrient"
  end
end