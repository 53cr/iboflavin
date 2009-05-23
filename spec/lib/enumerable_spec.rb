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
  context "#includes_all? should return" do
    
    context "true when given correct" do
      it "single argument" do
        [1,2,3].should include_all_of 1
      end
    
      it "multiple arguments" do
        [1,2,3].should include_all_of 1, 2
      end
    
      it "array with multiple elements" do
        [1,2,3].should include_all_of [1, 2]
      end
    
      it "key that exists in the hash" do
        { :first => "ryan", :last => "neufeld"}.should
          include_all_of :first
      end
    
      it "multiple keys that exist in the hash" do
        { :first => "ryan", :last => "neufeld"}.should
          include_all_of :first, :last
      end
    
      it "array of keys that exist in the hash" do
        { :first => "ryan", :last => "neufeld"}.should 
          include_all_of [:first, :last]
      end
    
      it "multiple levels of nested items and arrays" do
        [1,2,3].should include_all_of [[1,2],3]
      end
    end
    
    context "false when given incorrect" do
      # Now for the _not_'s
      it "single argument" do
        [1,2,3].should_not include_all_of 4
      end
    
      it "multiple arguments" do
        [1,2,3].should_not include_all_of 1, 4
      end
    
      it "array with multiple elements" do
        [1,2,3].should_not include_all_of [1, 4]
      end
    
      it "key that exists in the hash" do
        { :last => "neufeld"}.should_not 
          include_all_of :first
      end
    
      it "multiple keys that exist in the hash" do
        { :last => "neufeld"}.should_not 
          include_all_of :first, :last
      end
    
      it "array of keys that exist in the hash" do
        { :last => "neufeld"}.should_not 
          include_all_of [:first, :last]
      end
    
      it "multiple levels of nested items and arrays" do
        [1,2,3].should_not include_all_of [[1,2],4]
      end
    end
  end
end