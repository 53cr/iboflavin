begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

require 'grammar'

class UserInput

  attr_reader :count, :unit, :foodSearch

  def initialize(match)
    @count, @unit, @foodSearch = match
  end

  def self.parse(str)
    result = []
    Grammar::parse(str).each do |match|
      result << UserInput.new(match)
    end
    result
  end
end
