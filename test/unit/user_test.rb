require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  context "User" do
    should "not be older than 999" do
      user = User.new
      user.age = 1000
      should_be_invalid user
    end
  end
end
