# process: numerical quantifier should always be first. parse it, continue with rest.
# look for words {small, large, extra large, extralarge, etc.}. remove, use for weight I guess?
# look for the word "of". try searching s[0] as a weight for s[1]. If it doesn't exist, search for full phrase.

require 'activesupport'

%w{metric units numbers quantifier}.each do |inc|
  require File.join(File.dirname(__FILE__), 'vocabulary', inc)
end

module Vocabulary
  
  def self.parse(phrase)
    # Terminology I might get lazy and use:
    #  - generic quantifier (GQ): a phrase describing an amount of food, 
    #      applicable to any specific food, eg. "three", "2 litres", or "1.5lb"
    #  - specific quantifier (SQ): a phrase describing an amount of food,
    #      but for which we must determine the specific food before we know 
    #      the quantity implied. eg. "stick". A stick of celery is very 
    #      different from a stick of butter. Also, a "stick" of soup probably 
    #      doesn't match, but maybe there's a soup called "stick of soup". You never know...
    #  - food item (FI): A specific entry in the database.
    #  - Qualifier: The string we'll use to search the DB for FIs.

    # split on whitespace and hyphens.
    words = phrase.split(/[\s-]+/).map(&:downcase)
    
    # First we look for a GQ. If it's given, it'll be at the start of the phrase.
    # I can't think of a scenario where it would be given after an SQ / Qualifier anyway.
    generic_quantifier, words = Vocabulary::Quantifier::Generic::parse(words)
    
    # So now we've split the generic quantifier off the front of the phrase. We're 
    # left with something like: gq:["3"], words:["large", "sticks", "of", "celery"]

    # So now we have to find the specific quantifier (if any). We'll use a 
    # two-part strategy. First, pull off any words from the front like "large",
    # "small", etc. After that, split the input on the word "of", and use the first
    # half (if any) as the rest of the SQ. eg. for "large stick of celery", 
    # SQ=["large", "stick"], and Qualifier=["celery"]

    specific_quantifier = []
    qualifier = nil
    
    # however, if the generic quantifier already has units, we're not going to 
    # go hunting for a SQ!

    if ((!generic_quantifier.is_a?(Array)) || generic_quantifier[0].nil?)

      # SQ Step 1: freebie words (large, small, etc.)
      while Vocabulary::Quantifier::Specific::is_keyword(words[0])
        specific_quantifier << words.shift
      end
      
      # SQ Step 2: split on "of".
      if (of_idx = words.index("of"))
        # eg. "three cups of celery"
        specific_quantifier.concat(words[0...of_idx]) #=> "three cups"
        qualifier = words[of_idx+1..-1]             #=> "celery"
      end
      
    end
    
    # if we haven't already set it...
    qualifier ||= words
    qualifier.shift if qualifier[0] == "of"
    
    # Now, this may not be the real solution. For example, "cream of mushroom soup"
    # will try to use "cream" as a specific quantifier, when really, it should be 
    # part of the qualifier. However, we'll let the calling context deal with that,
    # since if the SQ turns up no hits, it's just a matter of joining SQ and Qualifier and
    # trying again. 

    return [generic_quantifier, specific_quantifier, qualifier]
  end
  
end
