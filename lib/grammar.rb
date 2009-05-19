require 'vocabulary'

module Grammar

  def self.parse(input)

    # Ok, so we have: one user input string. It probably contains
    # some sort of description of what they just ate, but you never know.
    # it might just be them slamming their face against the keyboard.

    # ||---\------------------------/-[object]-||
    #      |                        |
    #      \-[quantifier]-\--------//
    #                       |      |
    #                       \-(of)-/

    # What we're _expecting_ is some description of the food, possibly
    # prefixed with some description of how much food there was.
    # If no Amount Part is given, we assume one serving, and hope the DB
    # provides that information.

    # Collapse multiple spaces or dashses to singular ones
    input = input.gsub(/([\s-]+)/) do
      $1[0..0]
    end

    # Have split parts determine the object and quantifier for the input
    quantifier, object = split_parts(input)
    
    # Given a quantifier exists or not, assign the count and unit
    count, unit = if quantifier
                    parse_quantifier(quantifier)
                  else
                    [1, Vocabulary::Serving] # default to 1 serving
                  end
      
    return [count, unit, object]
    # RN: I think long term we want to return something like:
    #  [
    #   { food: object, count: count, unit: unit},
    #   ...
    #  ]
    #
    # OR
    #   {
    #     object => { count => unit }
    #   }
    
  end

  # Given a quantifier, return [count, unit], eg. "3.5oz of" => [0.103507353, Litre]
  def self.parse_quantifier(quantifier)
    # Split on spaces/dashes, then map false or unit+count to each word
    values = quantifier.split(/[\s-]+/).map{|e|Vocabulary::quantifier_value(e)}
    
    # take product of the values to get a total
    # TODO: Make hold up under strange quantifiers (eg "2 and 5 burgers")
    total = values.inject(1) do |acc, num|
      (acc *= num) if num.is_a? Numeric
      acc
    end

    # Seperate out count and unit and return
    count = total.to_f
    unit  = total.class
    unit  = Vocabulary::Serving if [Fixnum, Float].include?(unit)
    return count, unit
  end
  
  # Split the quantifier from the object and return [quantifier, object]
  def self.split_parts(input)
    # Get list of tokens from input by splitting on spaces/dashes
    tokens = input.downcase.split(/[\s-]+/)

    # Build marks, the list of tokens that appear to be quantifiers
    marks = tokens.inject([]) do |acc, token|
      acc << Vocabulary::quantifier_value(token)
    end

    # Build the quantifier back up again, to be used for splitting input
      # not ruby-esque, but more efficient. Deal with it.
    proposed_quantifier = ""
    marks.size.times do |i|
      break unless marks[i]
      proposed_quantifier << tokens[i] << " "
    end
    
    # Split at the edge of the proposed quantifier, returning [quantifier, object]
    splitting_point = proposed_quantifier.size
    
    term = splitting_point-2
    quantifier = (term<0) ? "" : input[0..term]

    object = input[splitting_point..-1]
    
    return quantifier, object
  end

  
end
