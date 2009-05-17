require 'forwardable'

module Vocabulary

  class Unit
    extend Forwardable
    def_delegators :@num, :inspect, :to_s
    def initialize(num)
      @num = num
    end
    def method_missing(sym, args)
      raise NoMethodError unless @num.respond_to?(sym)
      r=@num.send(sym, args)
      return (r.is_a? Numeric) ? (self.class.new(r)) : r
    end
  end
  
  class Gram  < Unit; end
  class Litre < Unit; end
  
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

  SHORT_PREFIXES = {
    "M" => 1_000_000,
    "K" => 1_000,
    "k" => 1_000,
    "h" => 100,
    "D" => 10,
    "d" => 0.1,
    "c" => 0.01,
    "m" => 0.001,
    "u" => 0.000_001,
    "n" => 0.000_000_001
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
    "litre"    => Litre.new(1),
    "quart"    => Litre.new(0.946352946),
    "pint"     => Litre.new(0.473176473),
    "gallon"   => Litre.new(3.78541178),
    "cup"      => Litre.new(0.236588236),
    "handful"  => Litre.new(0.059147059)
  }

  UNIT_ABBREVIATIONS = {
    "g"   => Gram.new(1),
    "lb"  => Gram.new(453.59237),

    "oz"  => Litre.new(0.029573530),
    "l"   => Litre.new(1),
    "qt"  => Litre.new(0.946352946),
    "pt"  => Litre.new(0.473176473),
    "gal" => Litre.new(3.78541178),
    "c"   => Litre.new(0.236588236),
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
  

end
