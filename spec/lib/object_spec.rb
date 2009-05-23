require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Enumerable do
  context "includes_all? extensions" do
    it "should respond to #includes_all?" do
      lambda {[1,2,3].includes_all?([1,2])}.should_not raise_error
    end
    it "should include? singular element"
    it "should include? argument delimitted elements"
    it "should include? elements in an array"
    it "should include? keys of a hash"
    it "should traverse multiple levels of nesting"
  end
end