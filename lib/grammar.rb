require 'pp'

module Grammar

  def self.parse(str)
    tokens        = tokenize(str)
    naive_phrases = naive_phrases(tokens) # split on conjunctions
    phrases       = recombine_split_quantifiers(naive_phrases)

    phrases.map! do |phrase|
      parse_phrase(phrase)
    end

    return phrases
    
  end

  def self.tokenize(str)
    return str.split(/[\s-]+/)
  end
  
  def self.naive_phrases(tokens)
    # split on conjunctions into the form:
    # "three and a half hamburgers and a hotdog with ketchup and three pounds of relish"
    #   [[nil, ["three"]],
    #    ["and", ["a", "half", "hamburgers"]],
    #    ["and", ["a", "hotdog"]],
    #    ["with", ["ketchup"]],
    #    ["and", ["three", "pounds", "of", "relish"]]]
    phrases = tokens.inject([[nil,[]]]) do |arr, word|
      if Vocabulary::CONJUNCTIONS.include?(word)
        arr << [word,[]]
      else
        arr.last[1] << word
      end
      arr
    end
    # I can't imagine why someone would end input with a conjunction, but...
    phrases = phrases[0..-2] if phrases.last[1] == [] # ...you never know.
    return phrases
  end

  def self.recombine_split_quantifiers(naive)
    #   [[nil, ["three"]],
    #    ["and", ["a", "half", "hamburgers"]],
    #    ["and", ["a", "hotdog"]],
    #    ["with", ["ketchup"]],
    #    ["and", ["three", "pounds", "of", "relish"]]]

    #   [["three", "and", "a", "half", "hamburgers"],
    #    ["a", "hotdog"],
    #    ["ketchup"],
    #    ["three", "pounds", "of", "relish"]]

    phrases = []

    append = false
    until naive.empty? do
      item = naive.shift
      phrase = item[1]
      if append
        phrases.last << item
        phrases.last.flatten!
      else
        phrases << phrase
      end
      append = phrase.all?{|e|Vocabulary::quantifier_value(e)}
    end

    return phrases
    
  end

  def self.parse_phrase(phrase)

    values = phrase.inject([]) do |acc, word|
      acc << Vocabulary::quantifier_value(word)
    end

    ### This could use improvement. ##########################
    object_index = values.index(false) #######################
    quantifier = parse_quantifier(values[0...object_index]) ##
    object = phrase[object_index..-1] ########################
    ##########################################################

    return [quantifier, object.join(' ')].flatten
  end

  def self.parse_quantifier(values)
    # "three and a half pounds"
    # [[3], [1/2, (1 pound)]]
    # [[3], [1/2 * (1 pound)]]
    # [3 + x]
    # y

    expr = [[1]]
    
    until values.empty?
      val = values.shift
      if val == :+
        expr << []
      else
        (expr.last << val) if val.is_a? Numeric
      end
    end
    
    total = expr.map { |subex|
      subex.inject(&:*)
    }.inject(&:+)
    
    count = total.to_f
    unit  = total.class
    unit  = Vocabulary::Serving if [Fixnum, Float].include?(unit)
    return count, unit
  end

end
