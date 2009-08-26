require File.join(File.dirname(__FILE__), "/../spec_helper")
require 'vocabulary'

describe "Vocabulary" do
  # Generate tests from the given test cases
  read_from = File.join(RAILS_ROOT,"/spec/lib/vocabulary.YAML")
  test_cases = YAML.load(File.read(read_from))

  test_cases.each do |input,expected|
    it "should recognize #{input} as #{expected}" do
      result = Vocabulary.parse(input).inspect
      result.should == expected
    end
  end
end
