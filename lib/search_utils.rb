require 'lingua/stemmer'

module SearchUtils

  STEM = Lingua::Stemmer.new
  
  def self.signaturize(str)
    # Stem and sort string by word
    STEM.stem(str).split(/[\s-]+/).sort.join(' ')
  end

  # Read a pantload of records from the database and cache some stuff in Tyrant.
  # this could take a while once we get a lot of updates. Offloading this task to
  # another slice is trivial, and would help a great deal when we get to that point.
  def self.build_cache()

    # yeah. It's that bad.
    em = EntryMatch.all

    # create a hash containing the number of times each FoodItem is used as a result
    # for each search term.
    food_item_frequency_for_searches = {}
    em.each do |m|
      (food_item_frequency_for_searches[m.search]      ||= Hash.new(0))[m.food_item_id] += 1
      if m.search != m.sigsearch
        (food_item_frequency_for_searches[m.sigsearch] ||= Hash.new(0))[m.food_item_id] += 1
      end
    end

    tokyo = Rufus::Tokyo::Tyrant.new('localhost',45001)

    # Run back through that hash and find the most popular FoodItem for each search.
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
      
      tokyo["s_#{search}"] = maxfreqid.to_s
    end

    tokyo.close
    
  end

end
