require 'vocabulary'

module Grammar

  def self.parse(input)

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

    input = input.gsub(/([\s-]+)/) do
      $1[0..0]
    end

    quantifier, object = split_parts(input)

    count, unit = parse_quantifier(quantifier)

    return [count, unit, object]
    
  end

  # Given a quantifier, return [count, unit], eg. "3.5oz of" => [0.103507353, Litre]
  def self.parse_quantifier(quantifier)
    values = quantifier.split(/[\s-]+/).map{|e|Vocabulary::quantifier_value(e)}
    
    total = values.inject(1) do |acc, num|
      (acc *= num) if num.is_a? Numeric
      acc
    end

    count = total.to_f
    unit  = total.class
    unit  = Vocabulary::Serving if [Fixnum, Float].include?(unit)
    return count, unit
  end
  
  # Split the quantifier from the object and return [quantifier, object]
  def self.split_parts(input)
    tokens = input.downcase.split(/[\s-]+/)

    tokens = input.downcase.split(/[\s-]+/)
    marks = []

    tokens.each_with_index do |el, i|
      marks[i] = Vocabulary::quantifier_value(el)
    end

    # not ruby-esque, but more efficient. Deal with it.
    str = ""
    marks.size.times do |i|
      break unless marks[i]
      str << tokens[i] << " "
    end
    
    splitting_point = str.size

    term = splitting_point-2
    return "" if term<0
    quantifier = input[0..term]

    object = input[splitting_point..-1]
    
    return quantifier, object
  end

  
end
