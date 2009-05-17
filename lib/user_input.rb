begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

require 'vocabulary'

class Gram  < Struct.new(:amt); end
class Litre < Struct.new(:amt); end

class UserInput

  def initialize(str)

    # Collapse multiple sequential spaces or hyphens to a single one.
    @input = str.gsub(/([\s-]+)/) do
      $1[0..0]
    end
    
    # Ok, so we have: one user input string. It probably contains
    # some sort of description of what they just ate, but you never know.
    # it might just be them slamming their face against the keyboard.

    # ||---\--------------------------/--[ Food Part ]----||
    #      |                          |
    #      \--[ Amount Part ]-\------//
    #                         |      |
    #                         \-(of)-/

    # What we're _expecting_ is some description of the food, possibly
    # prefixed with some description of how much food there was.
    # If no Amount Part is given, we assume one serving, and hope the DB
    # provides that information.

  end

  def mark_split

    tokens = @input.downcase.split(/[\s-]+/)

    quantifier = quantifier_part
    noun       = noun_part

    "#{quantifier}:::#{noun}"
    
  end

  def quantifier_part
    term = splitting_point-2
    return "" if term<0
    return @input[0..term]
  end

  def noun_part
    @input[splitting_point..-1]
  end
    
  def splitting_point
    return @splitting_point if @splitting_point

    tokens = @input.downcase.split(/[\s-]+/)
    marks = []

    tokens.each_with_index do |el, i|
      marks[i] = part_of_quantifier_vocabulary?(el)
    end

    # not ruby-esque, but more efficient. Deal with it.
    str = ""
    marks.size.times do |i|
      break unless marks[i]
      str << tokens[i] << " "
    end
    
    return (@splitting_point = str.size)
  end

  def part_of_quantifier_vocabulary?(word)
    return true if word =~ /^[\d\.]+\w{0,4}$/
    return true if Vocabulary::QUANTIFIER_VOCABULARY.include?(word)
    return true if Vocabulary::QUANTIFIER_VOCABULARY.include?(ActiveSupport::Inflector.singularize(word))
  end
  
end
