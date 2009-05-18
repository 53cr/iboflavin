namespace :test do
  namespace :generate do
    task :user_input do
      read_from = File.join(RAILS_ROOT,"/test/test_cases.YAML")
      test_cases = YAML.load(File.read(read_from))
      
      write_to = File.join(RAILS_ROOT,'/test/unit/user_input_test.rb')
      f = File.open(write_to, "w")
      
      f.print <<EOS
require 'test_helper'
require 'user_input'

\#\# Warning this is a generated file, do not directly modify it.
\#\#   Instead take a look at lib/tasks/test_generate.rake

class UserInputTest < ActiveSupport::TestCase
EOS
      
      test_cases.each do |input,expected|
        f.print <<EOC
  test "#{input}" do
    result = UserInput.new(\"#{input}\")
    expected = #{expected.inspect}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
EOC
      end
      
      f.print <<EOS
end
EOS
    end
  end
end
