begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

require 'grammar'

class UserInput

  attr_reader :count, :unit, :foodSearch
  
  def initialize(str)

    # Collapse multiple sequential spaces or hyphens to a single one.
    @input = str.gsub(/([\s-]+)/) do
      $1[0..0]
    end

    @count, @unit, @foodSearch = Grammar::parse(@input)

  end


end

# array.each do |input|
#     results = UserInput.new(input)
#     puts "\"#{input}\":"
#     puts "  count: #{results.count}"
#     puts "  unit:  \"#{results.unit}\""
#     puts "  foodSearch: \"#{results.foodSearch}\""
#   end
# end