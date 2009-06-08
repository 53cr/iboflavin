class FoodItem < ActiveRecord::Base
  
  belongs_to :food_group

  has_many :food_item_nutrients
  has_many :nutrients, :through => :food_item_nutrients

  TOKYO = Rufus::Tokyo::Tyrant.new('localhost',45001)
  
  define_index do
    indexes name
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

  private
  def self.user_most_recent(uid,sigtext)
    return EntryMatch.find(:first, :conditions => {:user_id => uid, :sigsearch => sigtext}).food_item rescue nil
  end

  def self.user_most_common(uid, sigtext, number_of_results = 5)
    query = "SELECT food_item_id "+
      "FROM entry_matches "+
      "WHERE user_id = ? "+
      "AND sigsearch = ? "+
      "GROUP BY food_item_id "+
      "ORDER BY count(*) DESC "+
      "LIMIT #{number_of_results}"

    query = ActiveRecord::Base.replace_bind_variables(query,[uid, sigtext])
    
    sql_result = ActiveRecord::Base.connection.execute(query)
    food_item_ids = sql_result.all_hashes.map{|e|e['food_item_id']}
    food_item_ids = food_item_ids.reject(&:nil?).map(&:to_i)
    return FoodItem.find(food_item_ids)
  end

  def self.global_most_common(sigtext, number_of_results = 5)
    query = "SELECT food_item_id "+
      "FROM entry_matches "+
      "WHERE sigsearch = ? "+
      "GROUP BY food_item_id "+
      "ORDER BY count(*) DESC "+
      "LIMIT #{number_of_results}"

    query = ActiveRecord::Base.replace_bind_variables(query,[sigtext])
    
    sql_result = ActiveRecord::Base.connection.execute(query)
    food_item_ids = sql_result.all_hashes.map{|e|e['food_item_id']}
    food_item_ids = food_item_ids.reject(&:nil?).map(&:to_i)
    return FoodItem.find(food_item_ids)
  end

  def self.text_search(text, limit=15)
    
    # all else fails, fire it off the the god-awful full-text search.
    # if we're running in development, don't freak out when sphinx isn't available.
    if RAILS_ENV=='development'
      begin
        return self.search(text,:limit=>limit)
      rescue
        return self.find(:all,:conditions=>['name LIKE ?',"%#{text}%"],:limit=>limit) rescue nil
      end
    else 
      return self.search(text,:limit=>limit)
    end

  end
  
end
