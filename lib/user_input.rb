begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

require 'grammar'

class UserInput

  def initialize(str)

    # Collapse multiple sequential spaces or hyphens to a single one.
    @input = str.gsub(/([\s-]+)/) do
      $1[0..0]
    end

    @count, @unit, @foodSearch = Grammar::parse(@input)

  end


end
