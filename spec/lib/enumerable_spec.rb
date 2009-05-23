require File.join(File.dirname(__FILE__), "/../spec_helper")

Spec::Matchers.define :include_all_of do |*args|
  match do |collection|
    collection.includes_all?(args)
  end
end

describe Enumerable do
  it "should respond to #includes_all?" do
    lambda {[1,2,3].includes_all?([1,2])}.should_not raise_error
    [1,2,3].should respond_to :includes_all?
    {:name => "Jeff"}.should respond_to :includes_all?
  end
  
  context "#includes_all? extensions" do
    it "should include? singular element" do
      [1,2,3].should include_all_of 1
    end
    
    it "should include argument delimitted elements" do
      [1,2,3].should include_all_of 1, 2
    end
    
    it "should include elements in an array" do
      [1,2,3].should include_all_of [1, 2]
    end
    
    it "should include single key of a hash" do
      { :first => "ryan", :last => "neufeld"}.should include_all_of :first
    end
    
    it "should include argument delimitted keys of a hash" do
      { :first => "ryan", :last => "neufeld"}.should include_all_of :first, :last
    end
    
    it "should include array of keys of a hash" do
      { :first => "ryan", :last => "neufeld"}.should include_all_of [:first, :last]
    end
    
    it "should traverse multiple levels of nesting" do
      [1,2,3].should include_all_of [[1,2],3]
    end
    
    # Now for the _not_'s
    it "false when including singular element" do
      [1,2,3].should_not include_all_of 4
    end
    
    it "false when including argument delimitted elements" do
      [1,2,3].should_not include_all_of 1, 4
    end
    
    it "false when including elements in an array" do
      [1,2,3].should_not include_all_of [1, 4]
    end
    
    it "false when including single key of a hash" do
      { :first => "ryan", :last => "neufeld"}.should_not include_all_of :third
    end
    
    it "false when including argument delimitted keys of a hash" do
      { :first => "ryan", :last => "neufeld"}.should_not include_all_of :first, :third
    end
    
    it "false when including array of keys of a hash" do
      { :first => "ryan", :last => "neufeld"}.should_not include_all_of [:first, :third]
    end
    
    it "false when traversing multiple levels of nesting" do
      [1,2,3].should_not include_all_of [[1,2],4]
    end
  end
end