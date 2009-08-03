module Vocabulary
  module Metric
    
    LONG_PREFIXES = {
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
    
  end
end
