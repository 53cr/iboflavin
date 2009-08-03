require "metric" unless defined? Vocabulary::Metric

module Vocabulary
  module Units

    LONG_UNITS = { 
      # Literally one serving
      "serving"    => [:serving, 1],
      "helping"    => [:serving, 1],
      
      # Highly subjective. Just guess. They can correct later.
      "some"       => [:serving, 1],
      "bit"        => [:serving, 1],
      "little"     => [:serving, 1],
      "lot"        => [:serving, 2],
      "bunch"      => [:serving, 2],
      
      # Weight-based
      "gram"       => [:gram, 1],
      "pound"      => [:gram, 453.59237],
      
      # Volume-based
      "tablespoon" => [:litre, 0.015],
      "teaspoon"   => [:litre, 0.005],
      "glass"      => [:litre, 0.250],
      "bottle"     => [:litre, 0.341],
      "can"        => [:litre, 0.335],
      "hogshead"   => [:litre, 238.480942],
      "ounce"      => [:litre, 0.029573530],
      "litre"      => [:litre, 1],
      "quart"      => [:litre, 0.946352946],
      "pint"       => [:litre, 0.473176473],
      "gallon"     => [:litre, 3.78541178],
      "cup"        => [:litre, 0.236588236],
      "handful"    => [:litre, 0.059147059]
    }

    
    SHORT_UNITS = { 
      "g"   => [:gram, 1],
      "lb"  => [:gram, 453.59237],
      
      "tsp" => [:litre, 0.005],
      "tbsp"=> [:litre, 0.015],
      "oz"  => [:litre, 0.029573530],
      "l"   => [:litre, 1],
      "qt"  => [:litre, 0.946352946],
      "pt"  => [:litre, 0.473176473],
      "gal" => [:litre, 3.78541178],
      "c"   => [:litre, 0.236588236]
    }
    
    PREFIXED_LONG_UNITS  = {}
    PREFIXED_SHORT_UNITS = {}
    
    Vocabulary::Metric::LONG_PREFIXES.each do |prefix, pval|
      LONG_UNITS.each do |unit, uval|
        # kilolitre:
        # [:litre, 1] * 1000 = [:litre, 1000]
        newval = [uval[0], pval*uval[1]]
        PREFIXED_LONG_UNITS.merge!({"#{prefix}#{unit}" => newval})
      end
    end

    Vocabulary::Metric::SHORT_PREFIXES.each do |prefix, pval|
      SHORT_UNITS.each do |unit, uval|
        # kL:
        # [:litre, 1] * 1000 = [:litre, 1000]
        newval = [uval[0], pval*uval[1]]
        PREFIXED_SHORT_UNITS.merge!({"#{prefix}#{unit}" => newval})
      end
    end

    UNITS = {}.
      merge(PREFIXED_SHORT_UNITS).
      merge(PREFIXED_LONG_UNITS).
      merge(SHORT_UNITS).
      merge(LONG_UNITS)
    
    def self.parse_unit(word)
      UNITS[word]
    end
    
  end
end
