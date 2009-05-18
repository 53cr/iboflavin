begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

require 'grammar'

class UserInput

  attr_reader :count, :unit, :foodSearch
  
  def initialize(str)

    @count, @unit, @foodSearch = Grammar::parse(@input)

  end


end
