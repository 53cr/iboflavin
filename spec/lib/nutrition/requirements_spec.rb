require File.join(File.dirname(__FILE__), "/../../spec_helper")
require 'nutrition'

module Nutrition
  describe Requirements do
    context "should give" do
      before(:all) do
        @valid_data = {
          :vit_a=>400, :vit_c=>40, :vit_d=>5, :vit_e=>4, :vit_k=>2.0,
          :thiamin=>0.2, :riboflavin=>0.3, :niacin=>2, :vit_b6=>0.1,
          :folate=>65, :vit_b12=>0.4, :pantothenic=>1.7, :biotin=>5,
          :choline=>125,
          :calcium=>210, :chromium=>0.2, :copper=>200, :fluoride=>0.01,
          :iodine=>110, :iron=>0.27, :magnesium=>30, :manganese=>0.003,
          :molybdenum=>2, :phosphorus=>100, :selenium=>15, :zinc=>2,
          :potassium=>0.4, :sodium=>0.12, :chloride=>0.18
        }
      end
      it "should reject vitamin/minerals that do not exist" do
        data = @valid_data.dup
        data[:popsicles] = 100
        lambda { Requirements.new(data) }.should raise_error "An imported vitamin has the wrong key"
      end
      
      it "should require all vitamins and mineral types be present" do
        pending
        invalid_data = @valid_data.dup
        invalid_data[:vit_a] = nil
        lambda { Requirements.new(invalid_data) }.should raise "The imported vitamins are missing a key"
      end
      
      it "should retain vitamin/mineral values passed in" do
        @valid_data[:vit_a] = 1234
        person_reqs = Requirements.new(@valid_data)
        person_reqs.for(:vit_a)[:value].should == 1234
      end
      
      it "should return vitamin/minerals with added units" do
        @valid_data.each_key {|key| @valid_data[key] = 1337}
        person_reqs = Requirements.new(@valid_data)
        @valid_data.each_key do |key|
          req = person_reqs.for(key)
          req.class.should   == Hash
          req[:value].should == 1337
          req[:unit].should  == Requirements::UNITS[key]
        end
      end
      
      it "should keep list of valid vitamins and minerals" do
        Requirements.valid_nutrients.empty? == false
        Requirements.valid_nutrients.should have(29).vitamins_and_minerals
      end
    end
  end
end