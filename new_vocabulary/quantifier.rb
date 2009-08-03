# I should really read some sort of language parsing or compiler book. Oh well.

# I'm using !!() here. Read it as to_boolean().

module Vocabulary
  module Quantifier

    module Generic
      
      # given a whole input phrase, return the generic quantity implied,
      # and the rest of the input that should be used to determine the FoodItem.
      def self.parse(words)
        rest = [] # rest of input (foodItem search phrase)
        gq = [] # generic quantifier
        
        # this is a really ugly way to do it. 
        # I couldn't think of anything slick. Sorry. :/

        # the quantifier _always_ leads input, so once we encounter a word that
        # isn't allowed in the quantifier, we read it and the rest of `words` 
        # into `rest`.
        gq_over = false 
        words.each do |word|
          if gq_over
            rest << word
          else
            if parse_token(word)
              gq << word
            else
              rest << word
              gq_over = true
            end
          end
        end

        # parse all of the tokens to get their numerical (and unit) values
        gq.map!{|e|parse_token(e)}
        
        # now, we sort of have a poor-man's AST...
        # "1 and 1/4 litre"
        # => [1.0, :+, 0.25, [:litre, 1]]
        
        # get rid of fluff.
        gq.reject!{|e|e==true || e==nil}
        
        # we COULD deal with stuff like "one and a half"... but we won't.
        gq.reject!{|e|e==:+}

        # multiply the whole shebang together. 
        # note that if nothing specifies a unit, we'll be returning [nil, x]
        total = [nil, 1]
        gq.each do |term|
          if term.kind_of?(Array)
            total[0] = term[0]
            total[1] *= term[1]
          else
            total[1] *= term
          end
        end

        return [total, rest]
      end

      # parse a single word as part of a quantifier.
      # return [:unit_name, value], eg. [:litre, 3.5], or just 2.5 if purely numerical.
      # also possible: `true` for "filler" words, and :+ for "and". Maybe others /shrug.
      def self.parse_token(token)
        number_part, word_part = nil
        # allow integers, real numbers, and fractions. We'll do this naively.
        token.sub(/^([\d\.\/]+)?\s*(.*)?$/) do 
          number_part = (($1.nil? || $1.empty?) ? nil : $1)
          word_part   = (($2.nil? || $2.empty?) ? nil : $2)
        end

        if number_part
          # parse this number as a fraction of two floats.
          frac_parts = number_part.split('/')
          number_value  = frac_parts[0].to_f
          (number_value = number_value / frac_parts[1].to_f) if frac_parts[1]
        end
        
        if word_part
          word_part = ActiveSupport::Inflector::singularize(word_part)
        end

        return number_value unless word_part

        word_value = GQ_VOCAB[word_part] || Vocabulary::Units::UNITS[word_part]
        # we have a word part, and we don't recognize it. Abort!
        return nil unless word_value

        # So at this point, we know we have a valid word_value, and we may or may not
        # have an attached number_value.
        if number_part
          if word_value.is_a?(Array)
            return [word_value[0], number_value*word_value[1]]
          else
            return word_value * number_value
          end
        else
          return word_value
        end
      end
      
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
      
      FILLER = {
        "a"   => true,
        "an"  => true,
        "and" => :+,
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

      GQ_VOCAB = {}.
        merge(MODIFIERS).
        merge(FILLER).
        merge(NUMBER_WORDS)
      
    end

    module Specific
      KEYWORDS = { 
        "large"   => true,
        "extra"   => true,
        "small"   => true,
        "regular" => true,
        "medium"  => true
      }
      
      def self.is_keyword(word)
        KEYWORDS[word]
      end
    end

  end
end
