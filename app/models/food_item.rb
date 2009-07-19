class FoodItem < ActiveRecord::Base

  belongs_to :food_group

  has_many :food_item_nutrients
  has_many :nutrients, :through => :food_item_nutrients

  define_index do
    indexes :name
  end

  def density
    read_attribute(:density) || 1
  end

  def serving_size
    read_attribute(:serving_size) || 150
  end

  def serving_size_unit
    read_attribute(:serving_size_unit) || "Grammar::Vocabulary::Gram"
  end

  def self.awesome_search(uid,text)
    sigtext = ::SearchUtils.signaturize(text)

    matches = []
    matches << user_most_recent(uid,sigtext)
    matches << user_most_common(uid,sigtext, 5)
    matches << global_most_common(sigtext, 5)
    matches << text_search(text)

    return matches.flatten.uniq.reject(&:nil?)
  end
  
  # Compute the two-ordered score for sorting
  #   Score is of the form [ 1 / # of matches, average distance ]
  #   This arises because we may have 1 or more query parts that aren't matched at all
  #     Since those elements return nil we can't exactly set them to 0 or MAX and expect reliable results
  #     e.g. "Carrot Soup" === ["carrot","soup"] = (0 + 8) / 2 = 4   # Clearly the best result
  #          "Carrot's, raw" === ["carr...soup"] = (0 + 0?) / 2 = 0  # but setting to 0 breaks this
  #          # Additionally setting the value arbitrarily high may cull results that are otherwise close but missing a word
  def ranking_score(query)
    d,l = 1,1 # Coefficients for distance and length
    queries = query.split
    text = self.name
    matches = 0

    total_distance = queries.inject(0) do |sum, query_part|
      # "Carrot SoUp" -> "carrot soup" # we need to match properly
      distance = text.downcase.index(query_part.downcase)
      if distance
        matches += 1
        sum + distance
      else
        sum
      end
    end

    avg_distance = total_distance / query.size
    # Set the reciprocal appropriately so no matches sorts to the end
    reciprocal = matches && matches > 0 ? matches : queries.size + 1

    #TODO: Try mixing the last two pieces together with coefficients - currently not a composite :(
    #  e.g. d * avg_distance + l * Absolute Length Difference
    #       where d and l are coefficients representing the importance of either factor
    [ reciprocal, d * avg_distance + l * (text.length - query.length).abs]
  end

  def query_parts_matched(query)
    
  end
  def self.ranking_sort(results,query)
    results.sort { |a,b| a.ranking_score(query) <=> b.ranking_score(query) }
  end

  def self.text_search(text, limit=15)

    # all else fails, fire it off the the god-awful full-text search.
    # if we're running in development, don't freak out when sphinx isn't available.
    if RAILS_ENV=='development'
      begin
        results = self.search(text,:limit=>limit, :match_mode => :any)
      rescue ThinkingSphinx::ConnectionError # only catch connection errors
        logger.warn " Be aware that sphinx isn't running/working but this was rescued becase you are in development"
        puts " ***** searchd isn't running: `rake ts:start` *****"
        results = self.find(:all,:conditions=>['name LIKE ?',"%#{text}%"],:limit=>limit) rescue nil
      end
    else
      results = self.search(text,:limit=>limit)
    end
    return ranking_sort(results,text)
  end

  private
  
  def self.user_most_recent(uid,sigtext)
    return EntryMatch.find(:first, :conditions => {:user_id => uid, :sigsearch => sigtext}, :order => 'id DESC').food_item rescue nil
  end

  def self.user_most_common(uid, sigtext, number_of_results = 5)
    query = "SELECT food_item_id "+
      "FROM entry_matches "+
      "WHERE user_id = ? "+
      "AND sigsearch = ? "+
      "GROUP BY food_item_id "+
      "ORDER BY count(*) DESC "+
      "LIMIT #{number_of_results}"

    food_item_ids = FoodItem.most_common_query_to_food_item_ids(query,sigtext,uid)

    return FoodItem.find(food_item_ids)
  end

  def self.global_most_common(sigtext, number_of_results = 5)
    query = "SELECT food_item_id "+
      "FROM entry_matches "+
      "WHERE sigsearch = ? "+
      "GROUP BY food_item_id "+
      "ORDER BY count(*) DESC "+
      "LIMIT #{number_of_results}"

    food_item_ids = FoodItem.most_common_query_to_food_item_ids(query,sigtext)

    return FoodItem.find(food_item_ids)
  end

  def self.most_common_query_to_food_item_ids(query,sigtext,uid=nil)
    vars = [uid,sigtext].compact #  Remove a nil default uid
    query = ActiveRecord::Base.replace_bind_variables(query,vars)
    sql_result = ActiveRecord::Base.connection.execute(query)
    if sql_result != []
    debugger
      food_item_ids = sql_result.all_hashes.map{|e|e['food_item_id']}
      food_item_ids = food_item_ids.reject(&:nil?).map(&:to_i)
    else
      food_item_ids = []
    end
    return food_item_ids
  end



end
