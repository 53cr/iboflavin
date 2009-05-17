require 'test_helper'
require 'user_input'

class UserInputTest < ActiveSupport::TestCase
  def test_cases
    {
      "Two bottles of Heineken" => "Two bottles of:::Heineken",
      "Five eggs" => "Five:::eggs"
    }.each do |key,value|
      self.instance_eval <<-EOS
         assert_equal UserInput.new("#{key}").mark_split, "#{value}"
      EOS
    end
  end
end

