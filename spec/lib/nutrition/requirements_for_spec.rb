require File.join(File.dirname(__FILE__), "/../../spec_helper")
require 'nutrition'

module Nutrition
  describe Requirements do
    before(:all) do
      @req = Nutrition::Requirements.new({:vit_a=>400, :vit_c=>40, :vit_d=>5, :vit_e=>4, :vit_k=>2.0,
      :thiamin=>0.2, :riboflavin=>0.3, :niacin=>2, :vit_b6=>0.1,
      :folate=>65, :vit_b12=>0.4, :pantothenic=>1.7, :biotin=>5,
      :choline=>125,
      :calcium=>210, :chromium=>0.2, :copper=>200, :fluoride=>0.01,
      :iodine=>110, :iron=>0.27, :magnesium=>30, :manganese=>0.003,
      :molybdenum=>2, :phosphorus=>100, :selenium=>15, :zinc=>2,
      :potassium=>0.4, :sodium=>0.12, :chloride=>0.18})
    end
    
    it "can translate Nutrient model instance to Requirements key" do
      Nutrition::Requirements::NUTRIENT_IDS_TO_NUTRIENT[320].should == :vit_a
    end
    
    # All Nutrients in Nutrition should have the same units as Nutrition
    Nutrition::Requirements::NUTRIENT_IDS_TO_NUTRIENT.each do |id, symbol|
      nutrient = Nutrient.find(id)
      it "should have the same units for #{nutrient.description}" do
        Nutrition::Requirements::UNITS[symbol].should == nutrient.unit.to_sym
      end
    end

    it "should return a value for a listed Nutrient" do
      @req.for(Nutrient.find(320)).should be 400
    end
    
    it "should return nil for an unlisted Nutrient" do
      Nutrition::Requirements::NUTRIENT_IDS_TO_NUTRIENT[1337].should == nil
    end
  end
end