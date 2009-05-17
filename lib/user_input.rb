begin
  require 'rubygems'
rescue LoadError;end
require 'activesupport'

class Gram  < Struct.new(:amt); end
class Litre < Struct.new(:amt); end

class UserInput

  PREFIXES = {
    "mega"  => 1_000_000,
    "kilo"  => 1_000,
    "hecto" => 100,
    "deka"  => 10,
    "deci"  => 0.1,
    "centi" => 0.01,
    "milli" => 0.001,
    "micro" => 0.000_001,
    "nano"  => 0.000_000_001
  }

  MODIFIERS = {
    "dozen"     => 12,
    "several"   => 5,
    "bunch"     => 7,
    "few"       => 3,
    "couple"    => 2,
    "half"      => 0.5,
    "third"     => 0.333333333,
    "quarter"   => 0.25,
    "fifth"     => 0.2,
    "sixth"     => 0.166666667,
    "seventh"   => 0.142857143,
    "eigth"     => 0.125,
    "ninth"     => 0.111111111,
    "tenth"     => 0.1,
    "twelfth"   => 0.083333333,
    "fifteenth" => 0.066666667,
    "twentieth" => 0.05,
    "thirtieth" => 0.033333333,
    "fiftieth"  => 0.02,
    "hundredth" => 0.01
  }
  
  UNITS = {
    "gram"     => Gram.new(1),
    "pound"    => Gram.new(453.59237),

    "glass"    => Litre.new(0.250),
    "bottle"   => Litre.new(0.341),
    "can"      => Litre.new(0.335),
    "hogshead" => Litre.new(238.480942),
    "ounce"    => Litre.new(0.029573530),
    "oz"       => Litre.new(0.029573530),
    "litre"    => Litre.new(1),
    "quart"    => Litre.new(0.946352946),
    "pint"     => Litre.new(0.473176473),
    "gallon"   => Litre.new(3.78541178),
    "cup"      => Litre.new(0.236588236),
    "handful"  => Litre.new(0.059147059)
  }

  FILLER = {
    "a"   => true,
    "of"  => true,
    "an"  => true,
    "and" => true,
    "the" => true
  }

  NUMBER_WORDS = {
    "one"       => 1,
    "two"       => 2,
    "three"     => 3,
    "four"      => 4,
    "five"      => 5,
    "six"       => 6,
    "seven"     => 7,
    "eight"     => 8,
    "nine"      => 9,
    "ten"       => 10,
    "eleven"    => 11,
    "twelve"    => 12,
    "thirteen"  => 13,
    "fourteen"  => 14,
    "fifteen"   => 15,
    "sixteen"   => 16,
    "seventeen" => 17,
    "eighteen"  => 18,
    "nineteen"  => 19,
    "twenty"    => 20,
    "thirty"    => 30,
    "forty"     => 40,
    "fifty"     => 50,
    "sixty"     => 60,
    "seventy"   => 70,
    "eighty"    => 80,
    "ninety"    => 90,
    "hundred"   => 100,
    "thousand"  => 1000
  }

  QUANTIFIER_VOCABULARY = MODIFIERS.
    merge(FILLER).
    merge(UNITS).
    merge(NUMBER_WORDS)
  
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
    return true if QUANTIFIER_VOCABULARY.include?(word)
    return true if QUANTIFIER_VOCABULARY.include?(ActiveSupport::Inflector.singularize(word))
  end
  
end

if __FILE__ == $0

  inputs = ["asdf", "1 taco", "1 taco", "marzipan", "marzipan", "Diet Pepsi MAX", "Very stale bread", "Bruschetta", "100g of marzipan", "3.5oz of marzipan", "1 glass of orange juice", "oh henry bar", "a coffee", "three donuts", "Nothing.", "Lunch", "subway", "two cookies", "bowl of cereal", "crackers and cottage cheese", "75 kg of a 100 kg bucket of chicken", "goddamn sandwiches", "classic italian sandwich and a mandarin orange and coffee", "cheesecake, toast with jam, orange juice", "Fuze Refresh", "Reeses big cups", "two eggs on toast", "steak", "spaghetti", "tortellini and spaghetti sauce with beef and chicken", "turd monkeys", "a cookie", "oatmeal bar", "a meatball sub", "pork and beans", "pankakes, bacon, eggs, and hashbrowns", "a pound of bacon", "several pounds of bacon", "meatballs and cheese", "eggs", "The number of gumballs that fit in my hat.", "bread", "eggs", "breakfast three times", "Two bottles of Heineken", "food", "chicken", "cupcakes", "pea soup", "cereal", "3 hotdogs and 4 glasses of coke", "3 hotdogs and 4 glasses of coke", "bacon chili cheesedog"]

  inputs.each do |x|
    puts UserInput.new(x).mark_split
  end
  
end
