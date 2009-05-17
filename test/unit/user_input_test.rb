require 'test_helper'
require 'user_input'

class UserInputTest < ActiveSupport::TestCase
  def test_two_eggs
    assert_equal UserInput.new("Two eggs").mark_split, "Two:::eggs"
  end
end
