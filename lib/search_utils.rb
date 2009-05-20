require 'lingua/stemmer'

module SearchUtils

  STEM = Lingua::Stemmer.new
  
  def self.signaturize(str)
    # Stem and sort string by word
    STEM.stem(str).split(/[\s-]+/).sort.join(' ')
  end
  
  def self.build_cache()

    # yeah. It's that bad.
    em = EntryMatch.all

    food_item_frequency_for_searches = {}
    em.each do |m|
      (food_item_frequency_for_searches[m.search]    ||= Hash.new(0))[m.food_item_id] += 1
      (food_item_frequency_for_searches[m.sigsearch] ||= Hash.new(0))[m.food_item_id] += 1
    end

    tokyo = Rufus::Tokyo::Tyrant.new('localhost',45001)
    
    top_food_item_for_search = {}
    food_item_frequency_for_searches.each do |search,ids|
      maxfreq=0
      maxfreqid=nil
      ids.each do |id,freq|
        if freq>maxfreq
          maxfreq=freq
          maxfreqid=id
        end
      end
      
      tokyo[search] = maxfreqid.to_s
    end

    tokyo.close
    
  end

end
