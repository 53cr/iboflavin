class FoodItem < ActiveRecord::Base
  
  belongs_to :food_group

  has_many :food_item_nutrients
  has_many :nutrients, :through => :food_item_nutrients

  has_many :weights
  
  TOKYO = Rufus::Tokyo::Tyrant.new('localhost',45001)
  
  define_index do
    indexes name
  end

  def density
    100
  end

  def serving_size
    150
  end

  def serving_size_unit
    "Grammar::Vocabulary::Gram"
  end
  
  def self.awesome_search(text)

    # first, try for most recent use by user
    #TODO
    
    # next, try global most popular
    if (food = TOKYO["s_#{text}"])
      return self.find(food.to_i)
    end

    sigtext = ::SearchUtils.signaturize(text)

    # try again with sigtext (most recent by user)
    #TODO
    
    # global most popular
    if (food = TOKYO["s_#{sigtext}"])
      return self.find(food.to_i)
    end

    # all else fails, fire it off the the god-awful full-text search.
    # if we're running in development, don't freak out when sphinx isn't available.
    if RAILS_ENV=='development'
      begin
        return self.search(text,:limit=>1).first rescue nil
      rescue
        return self.find(:first,:conditions=>['name LIKE ?',"%#{text}%"]) rescue nil
      end
    else 
      return self.search(text,:limit=>1).first rescue nil
    end
      
  end
  
end
