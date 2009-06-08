require File.join(File.dirname(__FILE__), "/../spec_helper")
# You might notice +/- 5 days here and there. The accuracy of many of the life stage classifications is sporadic because of Ruby Date year determination. Since this is not really a big deal I chose to take less accuracy as it really doesn't matter.

describe User do
  it { should have_many :entry_matches }
  it { should respond_to :report_for }
  
  it { should respond_to :rdi_for}
  # more specs?
  
  it { should respond_to :nutritional_requirements }
  describe "Nutrition Requirements" do
    it "should be a kind of Nutrition::Requirements"
    it "should cache its requirements for the current object"
    it "should update when user changes"
    # more specs

  end
  
  it "should return applicable nutrient requirements for a given nutrient"
end