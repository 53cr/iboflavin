module SearchResults

  def self.build_cache()

    # yeah. It's that bad.
    em = EntryMatch.all

    food_item_frequency_for_searches = {}
    em.each do |m|
      (food_item_frequency_for_searches[m.search] ||= Hash.new(0))[m.food_item_id] += 1
    end

    tokyo = Rufus::Tokyo::Cabinet.new("#{RAILS_ROOT}/db/top_food_cache.tch")
    
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
