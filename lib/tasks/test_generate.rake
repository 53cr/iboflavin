namespace :test do
  namespace :generate do
    task :user_input do
      read_from = File.join(RAILS_ROOT,"/test/gen_test-user_import.YAML")
      test_cases = YAML.load(File.read(read_from))
      
      write_to = File.join(RAILS_ROOT,'/test/unit/user_input_test.rb')
      f = File.open(write_to, "w")
      
      f.print <<EOS
require 'test_helper'
require 'user_input'

class UserInputTest < ActiveSupport::TestCase
EOS
      
      test_cases.each do |input,expected|
        f.print <<EOC
  def test_#{input.underscore.gsub(/[^a-zA-Z0-9\s]/,'').gsub(' ','_')}
    assert_equal UserInput.new("#{input}").mark_split, "#{expected}"
  end
EOC
      end
      
      f.print <<EOS
end
EOS
    end
  end
end
