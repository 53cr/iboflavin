require File.join(File.dirname(__FILE__), "/../spec_helper")
require 'user_input'
describe "Entry Recognition" do
  # Generate tests from the given test cases
  read_from = File.join(RAILS_ROOT,"/spec/lib/entry_recognition.YAML")
  test_cases = YAML.load(File.read(read_from))

  test_cases.each do |input,expected|
    it "should recognize #{input} as #{expected.inspect}" do
      results = UserInput.parse(input)
      results.each_with_index do |result,i|
        result.count.should      == expected[i]["count"]
        result.unit.to_s.should  == expected[i]["unit"]
        result.foodSearch.should == expected[i]["foodSearch"]
      end
    end
  end
end
